# Integer

- `gt(num: Int, message: String = "Must be greater than %@")`
- `gte(num: Int, message: String = "Must be at least %@")`
- `lt(num: Int, message: String = "Must be less than %@")`
- `lte(num: Int, message: String = "Must not be more than %@")`
- `positive(message: String = "Must be positive")`
- `nonNegative(message: String = "Must not be negative")`
- `negative(message: String = "Must be negative")`
- `nonPositive(message: String = "Must not be positive")`
- `multipleOf(num: Int,message: String = "Must be a multiple of %@")`

::: details Example
```swift
FormCraftValidationRules()
  .integer()
  .nonNegative() // [!code highlight]
  .multipleOf(5) // [!code highlight]
  .validate(value: 300)
```
:::
