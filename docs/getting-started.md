# Getting Started

## 📦 Installation

> [!NOTE]
> FormCraft is distributed via **Swift Package Manager (SPM)**.  
> Supported platforms: **iOS 16.0+**, **Xcode 14.0+**, **Swift 5.9+**

### 🔹 Adding with Xcode

1. Open your project in Xcode.  
2. Go to **File → Add Package Dependencies…**  
3. Paste the repository URL:  
   ```
   https://github.com/ArtyCodingart/form-craft
   ```  
4. Confirm and add **FormCraft** to your app target.

### 🔹 Using SwiftPM CLI

For projects managed entirely with SwiftPM, you can add FormCraft from the terminal:

```sh
swift package add-dependency https://github.com/ArtyCodingart/form-craft
```

## Create your first form

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
            }

            FormCraftControllerView(
                formConfig: loginForm,
                key: \.password
            ) { field in
                TextField("Email", text: field.$value)
                    .textFieldStyle(.roundedBorder)
                Text(field.error)
            }
        }

        Button("Login", action: loginForm.handleSubmit(onSuccess: handleLogin))
            .disabled(loginForm.formState.isSubmitting)
    }
}
```