# FormCraft <Badge type="tip" text="Class" />

`FormCraft` is the main form controller in the library.
It coordinates form state and validation, and provides the public API for working with a form.


## Constructor

```swift
init(
  fields: Fields,
  options: FormCraftOptions = .init()
)
```

### Arguments
- **fields: Fields** - a structure of fields conforming to [`FormCraftFields`](/api/formCraftFields). It describes all fields, their initial values, and validation rules.
- **options: FormCraftOptions** - global form behavior options.

  | Property | Type | Default | Description |
  |---|---|---|---|
  | `shouldFocusError` | `Bool` | `true` | Enables automatic focus on the first mounted field that currently has validation errors. |

## Properties

- **`fields: Fields`** - current form fields state (provided via `init(fields: Fields, options: FormCraftOptions)`).  
- **`options: FormCraftOptions`** - global options used by the form controller.  

- **`formState: FormCraftFormState<Fields>`** - overall form state.  
  Contains:  

  | Property | Type | Default | Description |
  |---|---|---|---|
  | `isSubmitting` | `Bool` | `false` | Indicates whether the submit flow is currently running. |
  | `focusedFieldKey` | `PartialKeyPath<Fields>?` | `nil` | Key path of the field that should be focused, or `nil`. |

## Methods

### Setting values

- **`setDefaultValues(_ pairs: repeat (WritableKeyPath<Fields, Field>, Field.Value))`** - updates default and current values for provided fields.  

---

### Errors

- **`setErrors(_ pairs: repeat (KeyPath<Fields, Field>, FormCraftFailure), options: FormCraftSetErrorsOptions = .init())`** - sets errors by key paths.  
- **`setErrors(errors: [String: [String]], options: FormCraftSetErrorsOptions = .init())`** - sets errors by field names.  
  Supports nested field keys when you use [`FormCraftGroup`](/api/formCraftGroup), for example: `"delivery.zipCode"` or `"customer.email"`.
- **`clearError<Field: FormCraftFieldConfigurable>(key: KeyPath<Fields, Field>)`** - clears the error of a specific field.  
- **`clearErrors()`** - clears all errors.  

---

### Focus

- **`setFocus<Field: FormCraftFieldConfigurable>(key: KeyPath<Fields, Field>?)`** - sets or clears focused field key.

---

### Validation

- **`validateField<Field: FormCraftFieldConfigurable>(key: KeyPath<Fields, Field>) async -> Bool`** - asynchronously validates a single field.  
- **`validateFields()`** - validates all fields and returns `true` if there are no errors.  

---

### Form submission

- **`handleSubmit(onSuccess: @escaping (_ data: FormCraftValidatedFields<Fields>) async -> Void) -> () -> Void`** - returns a closure intended for submit actions (for example, a button action).  
  It validates form data and calls `onSuccess` only when the form is valid.

Example:

```swift
@FormCraft
private struct LoginFields: FormCraftFields {
    var email = FormCraftField(value: "") { value in
        await FormCraftValidationRules()
            .string()
            .notEmpty()
            .email()
            .validate(value: value)
    }
}

@State private var form = FormCraft(fields: LoginFields())

private func onSubmit(
    data: FormCraftValidatedFields<LoginFields>
) async {
    // `data.email` is validated and typed
    print(data.email)
}

Button("Submit", action: form.handleSubmit(onSuccess: onSubmit))
