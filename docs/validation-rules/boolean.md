# Boolean

## checked

Value must be `true`.  

**Parameters**
- `message: String` – error message if the value is `false`

```swift
let checked = FormCraftValidationRules()
  .boolean()
  .checked()

checked.validate(value: true)  // ✅ is valid
checked.validate(value: false) // ❌ is not valid
```
