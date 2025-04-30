# Validation Rules

## Booleans

- `isTrue(message: String = "Value required")` - Validates that boolean value is `true`

::: details Example
```swift
FormCraftValidationRules()
  .boolean()
  .isTrue() // [!code highlight]
  .validate(false)
```
:::

## Strings

- `isNotEmpty(message: String = "Value required")`
- `email(message: String = "Value must be a valid email")`
- `phoneNumber(message: String = "Value must be a valid phone number")`
- `equalTo(to: String, message: String = "Values ​​do not match")`
- `minLength(min: Int, message: String = "Value must be at least %@ characters")`
- `maxLength(max: Int, message: String = "Value must not be more than %@")`

::: details Example
```swift
FormCraftValidationRules()
  .string()
  .isNotEmpty() // [!code highlight]
  .email() // [!code highlight]
  .validate(false)
```
:::

## Integers

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

## Decimals

- `gt(num: Decimal, message: String = "Value must be greater than %@")`
- `gte(num: Decimal, message: String = "Value must be at least %@")`
- `lt(num: Decimal, message: String = "Value must be less than %@")`
- `lte(num: Decimal, message: String = "Value must not be more than %@")`
- `isNonNegative(message: String = "Value must not be negative")`
- `isNegative(message: String = "Value must be negative")`
- `isNonPositive(message: String = "Value must not be positive")`
- `multipleOf(num: Decimal,message: String = "Value must be a multiple of %@")`

::: details Example
```swift
FormCraftValidationRules()
  .decimal()
  .isNonNegative() // [!code highlight]
  .multipleOf(5) // [!code highlight]
  .validate(nil)
```
:::

## Optionals

- `optional()`

::: details Example
```swift
FormCraftValidationRules()
  .boolean()
  .optional() // [!code highlight]
  .validate(nil)
```
:::
