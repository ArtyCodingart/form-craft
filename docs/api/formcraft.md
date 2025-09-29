# FormCraft
`FormCraft` - is the central class for working with forms in SwiftUI.
It manages field values, performs their validation, handles errors, and controls the submission process.
The main goal of `FormCraft` is to free the developer from routine: you define fields and rules, and the library automatically ensures data correctness and tracks the form state.


## Constructor

```swift
init(fields: Fields)
```

### Arguments
- **fields: Fields** - a structure of fields conforming to `FormCraftFields`. It describes all fields, their initial values, and validation rules.

## Properties

- **`fields: Fields`** - the current state of the form fields.  

- **`registeredFields: [String]`** - the list of registered field names. Used to track fields that actually participate in validation.  

- **`focusedFields: [String]`** - the set of field names that are currently focused (for example, active text fields).  

- **`errorFields: [String: String]`** - a dictionary of errors, where the key is the field name and the value is the error message.  

- **`validationFields: [Key: Task<Void, Never>]`** - a dictionary of active validation tasks.  

- **`validatedFields: [Key: Sendable]`** - a dictionary of successfully validated values.  

- **`formState: FormCraftFormState`** - the overall form state.  
  Contains:  

  | Property | Type   | Description |
  |---|---|---|
  | `isSubmitting` | `Bool` | Indicates whether the form is in the process of "submitting". Commonly used to disable the "Submit" button and show a loading indicator. |  

## Methods

### Registration

- **`registerField(key:name:)`** - adds a field to the list of tracked ones.  
- **`unregisterField(key:)`** - removes a field from the list.  

---

### Setting values

- **`setValue(key:value:config:)`** - changes the value of a single field.  
  If `shouldValidate = true` is specified in `config`, the field is validated immediately.  

- **`setValues(values:)`** - updates several fields at once.  

---

### Errors

- **`setError(key:message:)`** - sets an error for a specific field.  
- **`setErrors([String:String])`** - sets errors by field names.  
- **`setErrors([Key:String])`** - sets errors by field keys.  
- **`clearError(key:)`** - clears the error of a specific field.  
- **`clearErrors()`** - clears all errors.  

---

### Validation

- **`validateField(key:)`** - asynchronously validates a single field.  
- **`validateFields()`** - validates all fields and returns `true` if there are no errors.  

---

### Form submission

- **`handleSubmit(onSuccess:)`** - returns a closure for the "Submit" button.  
  When called:  
  1. sets `isSubmitting = true`;  
  2. validates all fields;  
  3. if everything is ok - calls `onSuccess` with valid data;  
  4. resets `isSubmitting = false`.  
