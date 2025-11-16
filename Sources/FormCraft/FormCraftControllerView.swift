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

public struct FieldState {
    public var errors: [LocalizedStringResource]
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
    private let content: (_ value: Binding<Value>, _ fieldState: FieldState) -> Content

    @FocusState private var isFocused: Bool
    @StateObject private var formCraftControllerVM: FormCraftControllerVM
    @State private var value: Binding<Value>

    private var formField: FormField {
        formConfig.fields[keyPath: key]
    }

    private var fieldState: FieldState {
        let errors = formConfig.errorFields.first(where: { $0.key == formField.name })?.value
        let isValidating = formConfig.validationFields[key]

        return .init(
            errors: errors?.errors ?? [],
            isValidating: isValidating != nil
        )
    }

    public init(
        formConfig: FormConfig,
        key: WritableKeyPath<FormConfig.Fields, FormField>,
        @ViewBuilder content: @escaping (_ value: Binding<Value>, _ fieldState: FieldState) -> Content
    ) {
        self.formConfig = formConfig
        self.key = key
        self.content = content

        self._formCraftControllerVM = .init(wrappedValue: FormCraftControllerVM(
            register: {
                formConfig.registerField(key: key, name: formConfig.fields[keyPath: key].name)
            },
            unRegister: {
                formConfig.unregisterField(key: key)
            }
        ))
        self._value = .init(wrappedValue: .init(
            get: { formConfig.fields[keyPath: key].value },
            set: { formConfig.fields[keyPath: key].value = $0 }
        ))
    }

    public var body: some View {
        content(value, fieldState)
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
            }
            .onChange(of: formConfig.fields[keyPath: key].value) { _ in
                if !isFocused {
                    return
                }

                Task {
                    await formConfig.validateField(key: key)
                }
            }
    }
}
