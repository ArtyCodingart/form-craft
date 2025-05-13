# Decimal

- `gt(num: Decimal, message: String = "Must be greater than %@")`
- `gte(num: Decimal, message: String = "Must be at least %@")`
- `lt(num: Decimal, message: String = "Must be less than %@")`
- `lte(num: Decimal, message: String = "Must not be more than %@")`
- `positive(message: String = "Must be positive")`
- `nonNegative(message: String = "Must not be negative")`
- `negative(message: String = "Must be negative")`
- `nonPositive(message: String = "Must not be positive")`
- `multipleOf(num: Decimal,message: String = "Must be a multiple of %@")`

::: details Example
```swift
FormCraftValidationRules()
  .decimal()
  .nonNegative() // [!code highlight]
  .multipleOf(5) // [!code highlight]
  .validate(value: 300)
```
:::
