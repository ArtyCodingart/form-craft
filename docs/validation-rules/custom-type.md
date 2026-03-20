# Custom Type

Use `customType<T>()` when you need validation for your own model type.

## Example

```swift
struct User: Sendable {
  let firstName: String
  let age: Int
}

let userValidation = FormCraftValidationRules()
  .customType<User>()
  .addRule { user in
    if user.firstName.isEmpty {
      return .failure(errors: .init(["First name is required"]))
    }

    return .success(value: user)
  }
  .addRule { user in
    if user.age < 18 {
      return .failure(errors: .init(["You must be at least 18"]))
    }

    return .success(value: user)
  }

let result = await userValidation.validate(value: .init(firstName: "Alex", age: 21))
```

## Notes

- `T` must conform to `Sendable`.
- Rules are executed in order.
- Validation stops on the first failure.
