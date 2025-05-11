# Integer

- `gt(num: Int, message: String = "Value must be greater than %@")`
- `gte(num: Int, message: String = "Value must be at least %@")`
- `lt(num: Int, message: String = "Value must be less than %@")`
- `lte(num: Int, message: String = "Value must not be more than %@")`
- `positive(message: String = "Value must be positive")`
- `nonNegative(message: String = "Value must not be negative")`
- `negative(message: String = "Value must be negative")`
- `nonPositive(message: String = "Value must not be positive")`
- `multipleOf(num: Int,message: String = "Value must be a multiple of %@")`

::: details Example
```swift
FormCraftValidationRules()
  .integer()
  .nonNegative() // [!code highlight]
  .multipleOf(5) // [!code highlight]
  .validate(value: 300)
```
:::
