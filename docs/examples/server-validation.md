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

    return !existingEmails.contains(email)
}

@FormCraft
private struct LoginFormFields: FormCraftFields {
    var login = FormCraftField(value: "") { value in
        let validationResult = await FormCraftValidationRules()
            .string()
            .trimmed()
            .notEmpty()
            .email()
            .validate(value: value)

        guard case .success(let validatedEmail) = validationResult else {
            return validationResult
        }

        let isValidEmail = await checkExistEmail(email: validatedEmail)

        if isValidEmail {
            return .success(value: validatedEmail)
        }

        return .failure(errors: .init(["Email already exists"]))
    }

    var password = FormCraftField(value: "") { value in
        await FormCraftValidationRules()
            .string()
            .trimmed()
            .notEmpty()
            .validate(value: value)
    }
}

struct ServerValidationFormView: View {
    @State private var loginForm = FormCraft(fields: LoginFormFields())

    private func handleLogin(
        data: FormCraftValidatedFields<LoginFormFields>
    ) async {
        print(data.login)
        print(data.password)
    }

    var body: some View {
        VStack(spacing: 12) {
            FormCraftView(formConfig: loginForm) {
                FormCraftControllerView(
                    formConfig: loginForm,
                    key: \.login
                ) { value, field in
                    TextField("Email", text: value)
                        .textFieldStyle(.roundedBorder)

                    if let firstError = field.errors?.messages.first {
                        Text(firstError)
                            .foregroundStyle(.red)
                    }

                    Text("Is validating: \(String(field.isValidation))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                FormCraftControllerView(
                    formConfig: loginForm,
                    key: \.password
                ) { value, field in
                    SecureField("Password", text: value)
                        .textFieldStyle(.roundedBorder)

                    if let firstError = field.errors?.messages.first {
                        Text(firstError)
                            .foregroundStyle(.red)
                    }
                }
            }

            Button("Login", action: loginForm.handleSubmit(onSuccess: handleLogin))
                .disabled(loginForm.formState.isSubmitting)
        }
    }
}
```
