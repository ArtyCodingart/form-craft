# Form Craft

![GitHub Release](https://img.shields.io/github/v/release/ArtyCodingart/form-craft?color=%239a60fe)
![Static Badge](https://img.shields.io/badge/iOS-15%2B-test?logo=apple)
![GitHub License](https://img.shields.io/github/license/ArtyCodingart/form-craft)
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
private struct LoginFormFields: FormCraftFields {
  var login = FormCraftField(name: "login", value: "") { value in
    FormCraftValidationRules()
      .string()
      .trimmed()
      .isNotEmpty()
      .email()
      .validate(value: value)
  }

  var password = FormCraftField(name: "password", value: "") { value in
    FormCraftValidationRules()
      .string()
      .trimmed()
      .isNotEmpty()
      .validate(value: value)
  }
}

struct LoginFormView: View {
  @StateObject private var loginForm = FormCraft(fields: LoginFormFields())

  private func handleLogin(
    fields: FormCraftValidatedFields<LoginFormFields>
  ) async {
    await sendRequstToServer(variables: LoginRequest(
      username: fields.getValue(key: \.login)
    ))
  }

  var body: some View {
    FormCraft(formConfig: loginForm) {
      FormCraftControllerView(
        formConfig: loginForm,
        key: \.login
      ) { field in
        YourTextField(
          label: "Login",
          error: field.isError,
          helperText: field.error,
          value: field.$value
        )
      }

      FormCraftControllerView(
        formConfig: loginForm,
        key: \.password
      ) { field in
        YourPasswordField(
          label: "Password",
          error: field.isError,
          helperText: field.error,
          value: field.$value
        )
      }
    }

    YourButton(
      label: "Login",
      loading: loginForm.formState.isSubmiting,
      action: {
        loginForm.handleSubmit(onSuccess: handleLogin)
      }
    )
  }
}
```

## CHANGELOG

[CHANGELOG](/CHANGELOG.md)
## License

[MIT](/LICENSE)
