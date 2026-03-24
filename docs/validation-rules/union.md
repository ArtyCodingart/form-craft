# Union

## union

Validates a raw value against multiple validators and succeeds when at least one rule matches.

On success, `union` returns a tuple of optional values where only the matched validator position is non-`nil`.
If no validators match, it returns `.failure` with combined errors from all attempted validators.

**Parameters**
- `value: Any` - raw value to validate
- `rules: repeat each Rule` - variadic validators conforming to `FormCraftValidationTypeRules`

**Signature**

```swift
func union<each Rule: FormCraftValidationTypeRules>(
  _ value: Any,
  _ rules: repeat each Rule
) async -> FormCraftValidationResponse<(repeat ((each Rule).Value)?)>
```

For two rules (`string`, `integer`), success type is inferred as:

```swift
FormCraftValidationResponse<(String?, Int?)>
```

### Example: first rule matches

```swift
let result = await FormCraftValidationRules().union(
  "hello@example.com",
  FormCraftValidationRules().string().email(),
  FormCraftValidationRules().integer().gt(num: 0)
)

switch result {
case .success(let (email, intValue)):
  if let email {
    print("Email:", email)
  }

  // `intValue` is `Int?` and will be `nil` here.
  if let intValue {
    print("Int:", intValue)
  }
case .failure(let errors):
  print(errors.messages)
}
```

### Example: second rule matches

```swift
let result = await FormCraftValidationRules().union(
  42,
  FormCraftValidationRules().string().notEmpty(),
  FormCraftValidationRules().integer().positive()
)

switch result {
case .success(let (stringValue, intValue)):
  // `stringValue` is `String?` and will be `nil` here.
  if let stringValue {
    print("String:", stringValue)
  }

  if let intValue {
    print("Int:", intValue) // 42
  }
case .failure(let errors):
  print(errors.messages)
}
```
