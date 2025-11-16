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
    var errorFields: [Name: FormCraftFailure] { get set }
    var validationFields: [Key: Task<Void, Never>] { get set }
    var formState: FormCraftFormState { get set }

    func registerField(key: Key, name: Name)
    func unregisterField(key: Key)
    func setError(key: Key, errors: FormCraftFailure)
    func setErrors(errors: [Key: FormCraftFailure])
    func setErrors(errors: [Name: [String]])
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

    func validate() async -> (ValidatedValue?, FormCraftFailure?)
}

public struct FormCraftFailure: Sendable {
    let errors: [LocalizedStringResource]

    public init(_ errors: [LocalizedStringResource]) {
        self.errors = errors
    }

    public init(_ errors: [String]) {
        self.errors = errors.map { .init(stringLiteral: $0) }
    }
}

public enum FormCraftValidationResponse<Value: Sendable> {
    case success(value: Value)
    case failure(errors: FormCraftFailure)

    public var errors: [LocalizedStringResource]? {
        if case .failure(let failure) = self {
            return failure.errors
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
    func refine(form: FormCraft<Self>) async -> [FormCraft<Self>.Key: FormCraftValidationResponse<Sendable>]
}

public extension FormCraftFields {
    @MainActor
    func refine(form: FormCraft<Self>) async -> [FormCraft<Self>.Key: FormCraftValidationResponse<Sendable>] {
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
    @Published public var errorFields: [Name: FormCraftFailure] = [:]
    @Published public var validationFields: [Key: Task<Void, Never>] = [:]
    @Published public var formState = FormCraftFormState(
        isSubmitting: false
    )

    private let initialFields: Fields
    private var fieldNameByKeyPath: [Key: Name] = [:]
    private var validatedFields: [Key: Sendable] = [:]

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

    public func setError(key: Key, errors: FormCraftFailure) {
        guard let name = fieldNameByKeyPath[key] else { return }

        errorFields[name] = errors
    }

    public func setErrors(errors: [Key: FormCraftFailure]) {
        errors.forEach { error in
            setError(key: error.key, errors: error.value)
        }
    }

    public func setErrors(errors: [String: [String]]) {
        errorFields = errors.mapValues { .init($0) }
    }

    public func clearError(key: Key) {
        guard let name = fieldNameByKeyPath[key] else { return }

        errorFields.removeValue(forKey: name)
    }

    public func clearErrors() {
        errorFields.removeAll()
    }

    private func refineErrors() async -> [Name: FormCraftFailure] {
        let results = await fields.refine(form: self)

        let pairs: [(Name, FormCraftFailure)] = results.compactMap { (key, result) in
            guard
                case let .failure(errors) = result,
                let name = fieldNameByKeyPath[key]
            else {
                return nil
            }

            return (name, errors)
        }

        return Dictionary(pairs, uniquingKeysWith: { _, new in new })
    }

    public func validateField(key: Key) async {
        validationFields[key]?.cancel()

        guard let field = fields[keyPath: key] as? any FormCraftFieldConfigurable else { return }

        validationFields[key] = Task {
            if field.delayValidation.seconds > 0 {
                try? await Task.sleep(for: .seconds(field.delayValidation.seconds))

                if Task.isCancelled {
                    return
                }
            }

            async let validation = field.validate()
            async let refinedErrors = refineErrors()

            let (validationResult, refinedResult) = await (validation, refinedErrors)
            let (validatedValue, validatedErrors) = validationResult
            let fieldErrors =
                (fieldNameByKeyPath[key].flatMap { refinedResult[$0] }?.errors ?? []) +
                (validatedErrors?.errors ?? [])

            if Task.isCancelled {
                return
            }

            if !fieldErrors.isEmpty {
                setError(
                    key: key,
                    errors: .init(fieldErrors)
                )
            } else {
                validatedFields[key] = validatedValue
                clearError(key: key)
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

    public func validate() async -> (ValidatedValue?, FormCraftFailure?) {
        let validationResponse = await rule(value)

        switch validationResponse {
        case .success(let validatedValue):
            return (validatedValue, nil)
        case .failure(let failure):
            return (nil, failure)
        }
    }
}
