# FormCraftField <Badge type="tip" text="Class" />

`FormCraftField<Value, ValidatedValue>` describes one form field.
It stores raw value, validation state, and async validation rule.

This type is typically used inside a [`FormCraftFields`](/api/formCraftFields) schema.

## Constructor

```swift
init(
    value: Value,
    delayValidation: FormCraftDelayValidation = .immediate,
    rule: @escaping (_ value: Value) async -> FormCraftValidationResponse<ValidatedValue>
)
```

### Arguments
- **`value: Value`** - the current value of the field.
- **`delayValidation: FormCraftDelayValidation`** - delay before field validation starts (default is `.immediate`).
- **`rule`** - async validation rule that returns `FormCraftValidationResponse<ValidatedValue>`.

Example:

```swift
var email = FormCraftField(value: "") { value in
    await FormCraftValidationRules()
        .string()
        .trimmed()
        .notEmpty()
        .email()
        .validate(value: value)
}
```

## Properties

| Property | Type | Default | Description |
|---|---|---|---|
| `value` | `Value` | `value` passed to init | Current field value. |
| `validatedValue` | `ValidatedValue?` | `nil` | Last validated value produced by a successful validation. |
| `defaultValue` | `Value` | same as initial `value` | Initial value used to determine whether the field was changed. |
| `mounted` | `Bool` | `false` | Whether this field is currently mounted in UI. |
| `errors` | `FormCraftFailure?` | `nil` | Current validation errors for the field. |
| `isValidation` | `Bool` | `false` | Whether validation is currently in progress. |
| `taskValidation` | `Task<Void, Never>?` | `nil` | Reference to the active validation task. |
| `isDirty` | `Bool` | `false` | Indicates whether the current value has changed from `defaultValue`. |
| `isError` | `Bool` | computed | Convenience flag that mirrors `errors != nil`. |
| `delayValidation` | `FormCraftDelayValidation` | `.immediate` | Delay policy used before validation starts. |
| `rule` | `(Value) async -> FormCraftValidationResponse<ValidatedValue>` | required | Validation function for the field value. |

## Methods

### validate

```swift
func validate() async -> FormCraftFailure?
```

Runs the field rule with current `value`.
- Returns `nil` when validation succeeds.
- Returns `FormCraftFailure` when validation fails.
