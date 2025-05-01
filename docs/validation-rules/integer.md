# Integer

- `gt(num: Int, message: String = "Value must be greater than %@")`
- `gte(num: Int, message: String = "Value must be at least %@")`
- `lt(num: Int, message: String = "Value must be less than %@")`
- `lte(num: Int, message: String = "Value must not be more than %@")`
- `isNonNegative(message: String = "Value must not be negative")`
- `isNegative(message: String = "Value must be negative")`
- `isNonPositive(message: String = "Value must not be positive")`
- `multipleOf(num: Int,message: String = "Value must be a multiple of %@")`

::: details Example
```swift
FormCraftValidationRules()
  .integer()
  .isNonNegative() // [!code highlight]
  .multipleOf(5) // [!code highlight]
  .validate(nil)
```
:::