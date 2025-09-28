# Server Validation

```swift
import SwiftUI
import FormCraft

private func checkExistEmail(email: String) async -> Bool {
    try? await Task.sleep(nanoseconds: 3_000_000_000)

    let existingEmails = [
        "test@gmail.com",
        "john.doe@example.com",
        "maria.smith@testmail.org",
        "alex_ivanov@demo.net",
        "user123@mydomain.co"
    ]

    if existingEmails.contains(email) {
        return false
    }

    return true
}

private struct LoginFormFields: FormCraftFields {
    var login = FormCraftField(name: "login", value: "") { value in
        let validateResult = await FormCraftValidationRules()
            .string()
            .trimmed()
            .notEmpty()
            .email()
            .validate(value: value)
        if case .error = validateResult {
            return validateResult
        }

        let isValidEmail = await checkExistEmail(email: value)

        if isValidEmail {
            return .success(value: value)
        }
        return .error(message: "Email already exists")
    }

    var password = FormCraftField(name: "password", value: "") { value in
        await FormCraftValidationRules()
            .string()
            .trimmed()
            .notEmpty()
            .validate(value: value)
    }
}

struct ServerValidationFormView: View {
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
                Text("Is validating: \(field.isValidating)")
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