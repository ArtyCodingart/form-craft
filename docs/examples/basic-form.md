# Basic Form

```swift
private struct LoginFormFields: FormCraftFields {
  var login = FormCraftField(name: "login", value: "") { value in
    FormCraftValidationRules()
      .string()
      .trimmed()
      .notEmpty()
      .email()
      .validate(value: value)
  }

  var password = FormCraftField(name: "password", value: "") { value in
    FormCraftValidationRules()
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
    await sendRequestToServer(variables: LoginRequest(
      username: fields.getValue(key: \.login),
      password: fields.getValue(key: \.password)
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
      loading: loginForm.formState.isSubmitting,
      action: {
        loginForm.handleSubmit(onSuccess: handleLogin)
      }
    )
  }
}
```
