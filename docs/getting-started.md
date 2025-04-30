# Getting Started

## Installation

### Prerequisites

- iOS 15+

### Using CLI

```sh
npm install --save form-craft
```

### Using XCode

```sh
npm install --save form-craft
```

## Create your first form

### Create form structure

Firstly you need to create a structure for Form Craft
that inherits `FormCraftFields` protocol.

Each your fields should be a property of this structure,
It should be instance of `FormCraftField`
that accepts `name` of field. which would be used for error handling;
and initial `value` of this field.

Last parameter is callback that accepts `value` from user-input,
and pass it through `FormCraftValidationRules()`.

> [!TIP] Note
> Validation rules applies one-by-one from top to bottom, so the order is matter.

Each rule-set starts from decaring a type of field like f.e. `.string()`,
then adding necessary validation rules, and finally call `.validate(value: value)`.

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
```

### Compose UI

Imagine you have some login form UI component named `LoginFormView`.

First thing that you need is add instance of `FormCraft` as a `@StateObject`,
with passing instance of previusly declared form into `fields` parameter.


```swift
struct LoginFormView: View {
  @StateObject private var loginForm = FormCraft(fields: LoginFormFields()) // [!code ++]
}
```

With Form Craft, each form should be wrapped into `FormCraft` component
with passing previously declared `loginForm` into `formConfig`.


```swift
struct LoginFormView: View {
  @StateObject private var loginForm = FormCraft(fields: LoginFormFields())

  var body: some View { // [!code ++]
    FormCraft(formConfig: loginForm) { // [!code ++]
      // ... // [!code ++]
    } // [!code ++]
  } // [!code ++]
}
```

Also each field, that you want to add, should be wrapped into `FormCraftControllerView`.

```swift
struct LoginFormView: View {
  @StateObject private var loginForm = FormCraft(fields: LoginFormFields())

  var body: some View {
    FormCraft(formConfig: loginForm) {
      FormCraftControllerView( // [!code ++]
        formConfig: loginForm, // [!code ++]
        key: \.login // key of field that declared in `LoginFormFields` // [!code ++]
      ) { field in // [!code ++]
        // ... // [!code ++]
      } // [!code ++]
    }
  }
}
```

Inside a `FormCraftControllerView` you can put any UI field you want.

```swift
struct LoginFormView: View {
  @StateObject private var loginForm = FormCraft(fields: LoginFormFields())

  var body: some View {
    FormCraft(formConfig: loginForm) {
      FormCraftControllerView(
        formConfig: loginForm,
        key: \.login // key of field that declared in `LoginFormFields`
      ) { field in
        YourTextField( // [!code ++]
          label: "Login", // [!code ++]
          error: field.isError, // is there an error in a field // [!code ++]
          helperText: field.error, // error message, if appear // [!code ++]
          value: field.$value // value ref // [!code ++]
        ) // [!code ++]
      }
    }
  }
}
```

The last step is to add a button to submit a form,
and a function to send request to server.

```swift
struct LoginFormView: View {
  @StateObject private var loginForm = FormCraft(fields: LoginFormFields())

  private func handleLogin( // [!code ++]
    fields: FormCraftValidatedFields<LoginFormFields> // [!code ++]
  ) async { // [!code ++]
    await sendRequstToServer(variables: LoginRequest( // [!code ++]
      username: fields.getValue(key: \.login), // [!code ++]
      password: fields.getValue(key: \.password) // [!code ++]
    )) // [!code ++]
  } // [!code ++]

  var body: some View {
    FormCraft(formConfig: loginForm) {
      FormCraftControllerView(
        formConfig: loginForm,
        key: \.login // key of field that declared in `LoginFormFields`
      ) { field in
        YourTextField(
          label: "Login",
          error: field.isError, // is there an error in a field
          helperText: field.error, // error message, if appear
          value: field.$value // value ref
        )
      }
    }

    YourButton( // [!code ++]
      label: "Login", // [!code ++]
      loading: loginForm.formState.isSubmiting, // [!code ++]
      action: { // [!code ++]
        loginForm.handleSubmit(onSuccess: handleLogin) // [!code ++]
      } // [!code ++]
    ) // [!code ++]
  }
}
```

## Full code of example

::: details Show full code

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
      loading: loginForm.formState.isSubmiting,
      action: {
        loginForm.handleSubmit(onSuccess: handleLogin)
      }
    )
  }
}
```

:::

## What's Next?

- Explore list of available [validation rules](/validation-rules)
- Check our [examples](/guide/examples)
