# Floating

`floating()` validates `Float` by default.

Use `floating(Double.self)` (or another floating-point type) when you need explicit type control.

## gt

Strictly greater than the specified number.

**Parameters**
- `num: T` - exclusive lower bound
- `message: ((T) -> LocalizedStringResource)?` - optional custom error message builder

```swift
let greaterThan = FormCraftValidationRules()
  .floating()
  .gt(num: 10)

greaterThan.validate(value: 15) // ✅ is valid
greaterThan.validate(value: 5)  // ❌ is not valid
```

## gte

Greater than or equal to the specified number.

**Parameters**
- `num: T` - inclusive lower bound
- `message: ((T) -> LocalizedStringResource)?` - optional custom error message builder

```swift
let greaterOrEqual = FormCraftValidationRules()
  .floating()
  .gte(num: 10)

greaterOrEqual.validate(value: 10) // ✅ is valid
greaterOrEqual.validate(value: 5)  // ❌ is not valid
```

## lt

Strictly less than the specified number.

**Parameters**
- `num: T` - exclusive upper bound
- `message: ((T) -> LocalizedStringResource)?` - optional custom error message builder

```swift
let lessThan = FormCraftValidationRules()
  .floating()
  .lt(num: 100)

lessThan.validate(value: 50)   // ✅ is valid
lessThan.validate(value: 150)  // ❌ is not valid
```

## lte

Less than or equal to the specified number.

**Parameters**
- `num: T` - inclusive upper bound
- `message: ((T) -> LocalizedStringResource)?` - optional custom error message builder

```swift
let lessOrEqual = FormCraftValidationRules()
  .floating()
  .lte(num: 100)

lessOrEqual.validate(value: 100) // ✅ is valid
lessOrEqual.validate(value: 101) // ❌ is not valid
```

## positive

Positive number (greater than zero).

**Parameters**
- `message: LocalizedStringResource` - error message if the value is not positive

```swift
let positive = FormCraftValidationRules()
  .floating()
  .positive()

positive.validate(value: 42)   // ✅ is valid
positive.validate(value: -10)  // ❌ is not valid
```

## nonNegative

Zero or positive.

**Parameters**
- `message: LocalizedStringResource` - error message if the value is negative

```swift
let nonNegative = FormCraftValidationRules()
  .floating()
  .nonNegative()

nonNegative.validate(value: 0)   // ✅ is valid
nonNegative.validate(value: -1)  // ❌ is not valid
```

## negative

Negative number (less than zero).

**Parameters**
- `message: LocalizedStringResource` - error message if the value is not negative

```swift
let negative = FormCraftValidationRules()
  .floating()
  .negative()

negative.validate(value: -5) // ✅ is valid
negative.validate(value: 5)  // ❌ is not valid
```

## nonPositive

Zero or negative.

**Parameters**
- `message: LocalizedStringResource` - error message if the value is positive

```swift
let nonPositive = FormCraftValidationRules()
  .floating()
  .nonPositive()

nonPositive.validate(value: 0)  // ✅ is valid
nonPositive.validate(value: 10) // ❌ is not valid
```

## multipleOf

Checks that the value is a multiple of the specified divisor.

**Parameters**
- `num: T` - divisor. If zero, validation fails
- `message: ((T) -> LocalizedStringResource)?` - optional custom error message builder

```swift
let multipleOf = FormCraftValidationRules()
  .floating()
  .multipleOf(num: 0.25)

multipleOf.validate(value: 0.75) // ✅ is valid
multipleOf.validate(value: 0.7)  // ❌ is not valid
```
