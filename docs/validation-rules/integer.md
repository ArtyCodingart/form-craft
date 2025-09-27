# Integer

## gt

Strictly greater than the specified number.

**Parameters**
- `num: Int` – exclusive lower bound  
- `message: String` – error message if the value is not greater

```swift
let greaterThan = FormCraftValidationRules()
  .integer()
  .gt(num: 10)

greaterThan.validate(value: 15) // ✅ is valid
greaterThan.validate(value: 5)  // ❌ is not valid
```

## gte

Greater than or equal to the specified number.

**Parameters**
- `num: Int` – inclusive lower bound  
- `message: String` – error message if the value is less

```swift
let greaterOrEqual = FormCraftValidationRules()
  .integer()
  .gte(num: 10)

greaterOrEqual.validate(value: 10) // ✅ is valid
greaterOrEqual.validate(value: 5)  // ❌ is not valid
```

## lt

Strictly less than the specified number.

**Parameters**
- `num: Int` – exclusive upper bound  
- `message: String` – error message if the value is not less

```swift
let lessThan = FormCraftValidationRules()
  .integer()
  .lt(num: 100)

lessThan.validate(value: 50)   // ✅ is valid
lessThan.validate(value: 150)  // ❌ is not valid
```

## lte

Less than or equal to the specified number.

**Parameters**
- `num: Int` – inclusive upper bound  
- `message: String` – error message if the value is greater

```swift
let lessOrEqual = FormCraftValidationRules()
  .integer()
  .lte(num: 100)

lessOrEqual.validate(value: 100) // ✅ is valid
lessOrEqual.validate(value: 101) // ❌ is not valid
```

## positive

Positive number (greater than zero).

**Parameters**
- `message: String` – error message if the value is not positive

```swift
let positive = FormCraftValidationRules()
  .integer()
  .positive()

positive.validate(value: 42)   // ✅ is valid
positive.validate(value: -10)  // ❌ is not valid
```

## nonNegative

Zero or positive.

**Parameters**
- `message: String` – error message if the value is negative

```swift
let nonNegative = FormCraftValidationRules()
  .integer()
  .nonNegative()

nonNegative.validate(value: 0)   // ✅ is valid
nonNegative.validate(value: -1)  // ❌ is not valid
```

## negative

Negative number (less than zero).

**Parameters**
- `message: String` – error message if the value is not negative

```swift
let negative = FormCraftValidationRules()
  .integer()
  .negative()

negative.validate(value: -5) // ✅ is valid
negative.validate(value: 5)  // ❌ is not valid
```

## nonPositive

Zero or negative.

**Parameters**
- `message: String` – error message if the value is positive

```swift
let nonPositive = FormCraftValidationRules()
  .integer()
  .nonPositive()

nonPositive.validate(value: 0)  // ✅ is valid
nonPositive.validate(value: 10) // ❌ is not valid
```

## multipleOf

Even divisibility by the specified number.

**Parameters**
- `num: Int` – divisor. If zero, validation fails  
- `message: String` – error message if the value is not a multiple

```swift
let multipleOf = FormCraftValidationRules()
  .integer()
  .multipleOf(num: 5)

multipleOf.validate(value: 20) // ✅ is valid
multipleOf.validate(value: 7)  // ❌ is not valid
```
