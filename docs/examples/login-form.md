# Login Form

```swift
import SwiftUI
import FormCraft

private struct LoginFormFields: FormCraftFields {
    var login = FormCraftField(name: "login", value: "") { value in
        await FormCraftValidationRules()
            .string()
            .trimmed()
            .notEmpty()
            .email()
            .validate(value: value)
    }

    var password = FormCraftField(name: "password", value: "") { value in
        await FormCraftValidationRules()
            .string()
            .trimmed()
            .notEmpty()
            .validate(value: value)
    }
}

struct LoginFormView: View {
    @StateObject private var loginForm = FormCraft(fields: LoginFormFields())

    private func handleLogin(
        fields: FormCraftValidatedFields<LoginFormFields>
    ) async {
        print(fields.login)
        print(fields.password)
    }

    var body: some View {
        FormCraftView(formConfig: loginForm) {
            FormCraftControllerView(
                formConfig: loginForm,
                key: \.login
            ) { field in
                TextField("Email", text: field.$value)
                    .textFieldStyle(.roundedBorder)
                Text(field.error)
                    .foregroundStyle(.red)
            }

            FormCraftControllerView(
                formConfig: loginForm,
                key: \.password
            ) { field in
                TextField("Email", text: field.$value)
                    .textFieldStyle(.roundedBorder)
                Text(field.error)
                    .foregroundStyle(.red)
            }
        }

        Button("Login", action: loginForm.handleSubmit(onSuccess: handleLogin))
            .disabled(loginForm.formState.isSubmitting)
    }
}
```
