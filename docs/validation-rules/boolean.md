# Boolean

- `checked(message: String = "Value required")` - Validates that boolean value is `true`

::: details Example
```swift
FormCraftValidationRules()
  .boolean()
  .checked() // [!code highlight]
  .validate(value: false)
```
:::
