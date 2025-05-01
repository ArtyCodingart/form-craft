# Boolean

- `isTrue(message: String = "Value required")` - Validates that boolean value is `true`

::: details Example
```swift
FormCraftValidationRules()
  .boolean()
  .isTrue() // [!code highlight]
  .validate(false)
```
:::