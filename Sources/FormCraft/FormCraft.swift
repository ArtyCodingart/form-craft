import SwiftUI
import Combine

@MainActor
public protocol FormCraftConfig: ObservableObject {
    associatedtype Fields: FormCraftFields
    typealias Name = String
    typealias Key = PartialKeyPath<Fields>

    var fields: Fields { get set }
    var registeredFields: [Name] { get set }
    var focusedFields: [String] { get set }
    var errorFields: [Name: LocalizedStringResource] { get set }
    var validationFields: [Key: Task<Void, Never>] { get set }
    var formState: FormCraftFormState { get set }

    func registerField(key: Key, name: Name)
    func unregisterField(key: Key)
    func setError(key: Key, message: LocalizedStringResource)
    func setErrors(errors: [Name: LocalizedStringResource])
    func setErrors(errors: [Name: String])
    func setErrors(errors: [Key: LocalizedStringResource])
    func setErrors(errors: [Key: String])
    func clearError(key: Key)
    func clearErrors()
    func validateField(key: Key) async
    func handleSubmit(onSuccess: @escaping (_ data: FormCraftValidatedFields<Fields>) async -> Void) -> () -> Void
    func setValue<Field: FormCraftFieldConfigurable>(
        key: WritableKeyPath<Fields, Field>,
        value: Field.Value,
        config: FormCraftSetValueConfig?
    )
    func setValues<Field: FormCraftFieldConfigurable>(
        values: [WritableKeyPath<Fields, Field>: Field.Value]
    )
}

public protocol FormCraftFieldConfigurable {
    associatedtype Value: Equatable & Sendable
    associatedtype ValidatedValue: Sendable

    var name: String { get }
    var value: Value { get set }
    var delayValidation: FormCraftDelayValidation { get }
    var rule: (_ value: Value) async -> FormCraftValidationResponse<ValidatedValue> { get }

    func validate() async -> (ValidatedValue?, LocalizedStringResource?)
}

public enum FormCraftValidationResponse<Value: Sendable>: Error {
    case success(value: Value)
    case error(message: LocalizedStringResource)

    public var errorMessage: LocalizedStringResource? {
        if case .error(let message) = self {
            return message
        }

        return nil
    }

    public var value: Value? {
        if case .success(let value) = self {
            return value
        }

        return nil
    }
}

public struct FormCraftFormState {
    public var isSubmitting: Bool

    public init(isSubmitting: Bool) {
        self.isSubmitting = isSubmitting
    }
}

public struct FormCraftSetValueConfig {
    public let shouldValidate: Bool

    public init(shouldValidate: Bool) {
        self.shouldValidate = shouldValidate
    }
}

@dynamicMemberLookup @MainActor
public struct FormCraftValidatedFields<Fields> {
    private let fields: Fields
    private let validatedFields: [PartialKeyPath<Fields>: Sendable]

    public init(
        fields: Fields,
        validatedFields: [PartialKeyPath<Fields>: Sendable]
    ) {
        self.fields = fields
        self.validatedFields = validatedFields
    }

    public subscript<Field: FormCraftFieldConfigurable>(
        dynamicMember keyPath: KeyPath<Fields, Field>
    ) -> Field.ValidatedValue {
        validatedFields[keyPath] as! Field.ValidatedValue
    }
}

public protocol FormCraftFields {
    @MainActor
    func refine(form: FormCraft<Self>) async -> [FormCraft<Self>.Key: LocalizedStringResource?]
}

public extension FormCraftFields {
    @MainActor
    func refine(form: FormCraft<Self>) async -> [FormCraft<Self>.Key: LocalizedStringResource?] {
        [:]
    }
}

public enum FormCraftDelayValidation {
    case immediate
    case fast
    case medium
    case slow
    case custom(seconds: Double)

    public var seconds: Double {
        switch self {
        case .immediate:
            return 0
        case .fast:
            return 0.2
        case .medium:
            return 0.5
        case .slow:
            return 1.0
        case .custom(let seconds):
            return seconds
        }
    }
}

public final class FormCraft<Fields: FormCraftFields>: FormCraftConfig {
    public typealias Name = String
    public typealias Key = PartialKeyPath<Fields>

    @Published public var fields: Fields
    public var registeredFields: [Name] = []
    @Published public var focusedFields: [String] = []
    @Published public var errorFields: [Name: LocalizedStringResource] = [:]
    @Published public var validationFields: [Key: Task<Void, Never>] = [:]
    @Published public var formState = FormCraftFormState(
        isSubmitting: false
    )
    @Published public var validatedFields: [Key: Sendable] = [:]

    private let initialFields: Fields
    private var fieldNameByKeyPath: [Key: String] = [:]
    private var validationTask: Task<Void, Never>?

    public init(fields: Fields) {
        self.initialFields = fields
        self.fields = fields
    }

    public func registerField(key: Key, name: Name) {
        fieldNameByKeyPath[key] = name

        if registeredFields.contains(name) {
            return
        }

        registeredFields.append(name)
    }

    public func unregisterField(key: Key) {
        guard let name = fieldNameByKeyPath[key] else { return }

        fieldNameByKeyPath.removeValue(forKey: key)

        registeredFields.removeAll(where: { $0 == name })
    }

    public func setError(key: Key, message: LocalizedStringResource) {
        guard let name = fieldNameByKeyPath[key] else { return }

        errorFields[name] = message
    }

    public func setErrors(errors: [String: LocalizedStringResource]) {
        errorFields = errors
    }

    public func setErrors(errors: [String: String]) {
        errorFields = errors.mapValues { .init(stringLiteral: $0) }
    }

    public func setErrors(errors: [Key: LocalizedStringResource]) {
        errors.forEach { error in
            setError(key: error.key, message: error.value)
        }
    }

    public func setErrors(errors: [Key: String]) {
        errors.forEach { error in
            setError(key: error.key, message: .init(stringLiteral: error.value))
        }
    }

    public func clearError(key: Key) {
        guard let name = fieldNameByKeyPath[key] else { return }

        errorFields.removeValue(forKey: name)
    }

    public func clearErrors() {
        errorFields.removeAll()
    }

    public func validateField(key: Key) async {
        validationFields[key]?.cancel()

        guard let field = fields[keyPath: key] as? any FormCraftFieldConfigurable else { return }

        validationFields[key] = Task {
            try? await Task.sleep(nanoseconds: UInt64(field.delayValidation.seconds * 1_000_000_000))

            if Task.isCancelled {
                return
            }

            let (validatedValue, errorMessage) = await field.validate()

            if Task.isCancelled {
                return
            }

            if let errorMessage {
                setError(
                    key: key,
                    message: errorMessage
                )
                validatedFields.removeValue(forKey: key)
            } else {
                validatedFields[key] = validatedValue
                clearError(key: key)
            }

            let refineErrors = await fields.refine(form: self)

            if Task.isCancelled {
                return
            }

            refineErrors.forEach { errorKey, value in
                if value == nil {
                    return
                }

                guard let name = fieldNameByKeyPath[errorKey] else { return }

                if errorMessage != nil && key == errorKey {
                    return
                }

                errorFields[name] = value
            }

            validationFields.removeValue(forKey: key)
        }

        await validationFields[key]?.value
    }

    public func validateFields() async -> Bool {
        let copy = fieldNameByKeyPath

        return await Task {
            let keys = Array(copy.keys)

            var tasks: [Task<Void, Never>] = []

            for key in keys {
                let task = Task { @MainActor in
                    await self.validateField(key: key)
                }
                tasks.append(task)
            }

            for task in tasks {
                await task.value
            }

            return errorFields.count == 0
        }.value
    }

    public func handleSubmit(
        onSuccess: @escaping (_ data: FormCraftValidatedFields<Fields>) async -> Void
    ) -> () -> Void {
        {
            self.formState.isSubmitting = true

            Task { [weak self] in
                guard let self else { return }

                let isValid = await self.validateFields()

                if isValid {
                    await onSuccess(FormCraftValidatedFields(
                        fields: self.fields,
                        validatedFields: self.validatedFields
                    ))
                }

                self.formState.isSubmitting = false
            }
        }
    }

    public func setValue<Field: FormCraftFieldConfigurable>(
        key: WritableKeyPath<Fields, Field>,
        value: Field.Value,
        config: FormCraftSetValueConfig? = nil
    ) {
        fields[keyPath: key].value = value

        if config?.shouldValidate == true {
            Task { await validateField(key: key) }
        }
    }

    public func setValues<Field: FormCraftFieldConfigurable>(
        values: [WritableKeyPath<Fields, Field> : Field.Value]
    ) {
        var newFields = fields

        values.forEach { item in
            newFields[keyPath: item.key].value = item.value
        }

        fields = newFields
    }
}

public struct FormCraftField<Value: Equatable & Sendable, ValidatedValue: Sendable>: FormCraftFieldConfigurable {
    public let name: String
    public var value: Value
    public var delayValidation: FormCraftDelayValidation
    public let rule: (_ value: Value) async -> FormCraftValidationResponse<ValidatedValue>

    public init(
        name: String,
        value: Value,
        delayValidation: FormCraftDelayValidation = .immediate,
        rule: @escaping (_ value: Value) async -> FormCraftValidationResponse<ValidatedValue>
    ) {
        self.name = name
        self.value = value
        self.delayValidation = delayValidation
        self.rule = rule
    }

    public func validate() async -> (ValidatedValue?, LocalizedStringResource?) {
        let validationResponse = await rule(value)

        switch validationResponse {
        case .success(let validatedValue):
            return (validatedValue, nil)
        case .error(let message):
            return (nil, message)
        }
    }
}
