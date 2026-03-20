# Getting Started

## Installation

FormCraft is distributed via Swift Package Manager (SPM).

Supported platforms:
- iOS 17+
- macOS 13+

### Add with Xcode

1. Open your project in Xcode.
2. Go to `File -> Add Package Dependencies...`
3. Paste:

```txt
https://github.com/ArtyCodingart/form-craft
```

4. Add `FormCraft` to your app target.

### Add with `Package.swift`

```swift
dependencies: [
    .package(url: "https://github.com/ArtyCodingart/form-craft", from: "x.y.z")
]
```

## First Form

This example shows the full happy path:
- define typed fields
- bind them to SwiftUI controls
- submit only validated data

```swift
import SwiftUI
import FormCraft

@FormCraft
private struct LoginFields: FormCraftFields {
    var email = FormCraftField(value: "") { value in
        await FormCraftValidationRules()
            .string()
            .trimmed()
            .notEmpty()
            .email()
            .validate(value: value)
    }

    var password = FormCraftField(value: "") { value in
        await FormCraftValidationRules()
            .string()
            .trimmed()
            .notEmpty()
            .min(min: 8)
            .validate(value: value)
    }
}

struct LoginFormView: View {
    @State private var form = FormCraft(fields: LoginFields())

    var body: some View {
        VStack(spacing: 12) {
            FormCraftView(formConfig: form) {
                FormCraftControllerView(formConfig: form, key: \.email) { value, field in
                    TextField("Email", text: value)
                        .textFieldStyle(.roundedBorder)

                    if let firstError = field.errors?.messages.first {
                        Text(firstError)
                            .foregroundStyle(.red)
                    }
                }

                FormCraftControllerView(formConfig: form, key: \.password) { value, field in
                    SecureField("Password", text: value)
                        .textFieldStyle(.roundedBorder)

                    if let firstError = field.errors?.messages.first {
                        Text(firstError)
                            .foregroundStyle(.red)
                    }
                }
            }

            Button(
                "Login",
                action: form.handleSubmit { data in
                    // `data` contains typed validated values.
                    print(data.email)
                    print(data.password)
                }
            )
            .disabled(form.formState.isSubmitting)
        }
        .padding()
    }
}
```
