import SwiftUI

private class FormCraftControllerVM: ObservableObject {
    private let unRegister: () -> Void

    init(
        register: () -> Void,
        unRegister: @escaping () -> Void
    ) {
        register()

        self.unRegister = unRegister
    }

    deinit {
        unRegister()
    }
}

public struct FieldState<Value> {
    @Binding public var value: Value
    public var isError: Bool
    public var error: String
    public var isValidating: Bool
}

public struct FormCraftControllerView<
    FormConfig: FormCraftConfig,
    FormField: FormCraftFieldConfigurable,
    Content: View
>: View {
    public typealias Value = FormField.Value

    @ObservedObject private var formConfig: FormConfig
    private let key: WritableKeyPath<FormConfig.Fields, FormField>
    private let content: (_ fieldState: FieldState<Value>) -> Content

    @FocusState private var isFocused: Bool
    @StateObject private var formKitControllerVM: FormCraftControllerVM

    private var formField: FormField {
        formConfig.fields[keyPath: key]
    }
    private var fieldState: FieldState<Value> {
        let binding = Binding(
            get: {
                formConfig.fields[keyPath: key].value
            },
            set: {
                formConfig.fields[keyPath: key].value = $0
            }
        )
        let error = formConfig.errorFields.first(where: { $0.key == formField.name })?.value ?? ""
        let isValidating = formConfig.validationFields[key]

        return FieldState(
            value: binding,
            isError: !error.isEmpty,
            error: error,
            isValidating: isValidating != nil
        )
    }

    public init(
        formConfig: FormConfig,
        key: WritableKeyPath<FormConfig.Fields, FormField>,
        @ViewBuilder content: @escaping (_ fieldState: FieldState<Value>) -> Content
    ) {
        self.formConfig = formConfig
        self.key = key
        self.content = content

        self._formKitControllerVM = .init(wrappedValue: FormCraftControllerVM(
            register: {
                formConfig.registerField(key: key, name: formConfig.fields[keyPath: key].name)
            },
            unRegister: {
                formConfig.unRegisterField(key: key)
            }
        ))
    }

    public var body: some View {
        content(fieldState)
            .focused($isFocused)
            .onChange(of: formConfig.focusedFields) { value in
                isFocused = value.contains(formField.name)
            }
            .onChange(of: isFocused) { value in
                if value {
                    formConfig.focusedFields.append(formField.name)

                    return
                }
                formConfig.focusedFields.removeAll(where: { $0 == formField.name })

                Task { await formConfig.validateField(key: key) }
            }
            .onChange(of: formConfig.fields[keyPath: key].value) { _ in
                Task {
                    await formConfig.validateField(key: key)
                }
            }
    }
}
