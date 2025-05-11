# String

- `notEmpty(message: String = "Value required")`
- `email(message: String = "Value must be a valid email")`
- `phoneNumber(message: String = "Value must be a valid phone number")`
- `equalTo(to: String, message: String = "Values ​​do not match")`
- `minLength(min: Int, message: String = "Value must be at least %@ characters")`
- `maxLength(max: Int, message: String = "Value must not be more than %@")`

::: details Example
```swift
FormCraftValidationRules()
  .string()
  .notEmpty() // [!code highlight]
  .email() // [!code highlight]
  .validate(value: "john.doe@gmail.com")
```
:::
