# Boolean

- `enabled(message: String = "Value required")` - Validates that boolean value is `true`

::: details Example
```swift
FormCraftValidationRules()
  .boolean()
  .enabled() // [!code highlight]
  .validate(value: false)
```
:::
