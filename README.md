# Form Craft

![GitHub Release](https://img.shields.io/github/v/release/ArtyCodingart/form-craft?color=%239a60fe)
![Static Badge](https://img.shields.io/badge/iOS-15%2B-test?logo=apple)
![GitHub License](https://img.shields.io/github/license/ArtyCodingart/form-craft)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/ArtyCodingart/form-craft/tests.yml?branch=main)
[![DOCS](https://img.shields.io/badge/DOCS-8A2BE2)](https://artycodingart.github.io/form-craft/)


Build better forms with a simple and flexible validation library for Swift and SwiftUI

## Key Features

- 💜 Modern Swift / iOS 15+
- ⚡ Built with performance, UX and DX in mind
- 🔀 Async validation in off-main thread
- ☂️ Type-Safe validation
- 🔨 Extendable validation rules
- 🎮 Compatible with any UI fields you want
- 🕑 Built-in debounce

## Basic example

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

## CHANGELOG

[CHANGELOG](/CHANGELOG.md)
## License

[MIT](/LICENSE)
