# Union

## union

Validates a raw value against multiple validators and succeeds when at least one rule matches.

On success, `union` returns a tuple of optional values where only the matched validator position is non-`nil`.
If no validators match, it returns `.failure` with combined errors from all attempted validators.

**Parameters**
- `value: Any` - raw value to validate
- `rules: repeat each Rule` - variadic validators conforming to `FormCraftValidationTypeRules`

```swift
let result = await FormCraftValidationRules().union(
  "hello@example.com",
  FormCraftValidationRules().string().email(),
  FormCraftValidationRules().integer().gt(num: 0)
)

switch result {
case .success(let tuple):
  let email = tuple.0
  let intValue = tuple.1
  print(email as Any)    // Optional("hello@example.com")
  print(intValue as Any) // nil
case .failure(let errors):
  print(errors.messages)
}
```

### Another example

```swift
let result = await FormCraftValidationRules().union(
  42,
  FormCraftValidationRules().string().notEmpty(),
  FormCraftValidationRules().integer().positive()
)

switch result {
case .success(let tuple):
  print(tuple.0 as Any) // nil
  print(tuple.1 as Any) // Optional(42)
case .failure(let errors):
  print(errors.messages)
}
```
