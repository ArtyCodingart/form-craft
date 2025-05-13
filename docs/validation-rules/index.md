# Validation Rules

## Example usage

FormCraft includes a wide set of built-in validation rules out of the box.
You can also define your own custom rules when needed.

FormCraft provides the `FormCraftValidationRules` structure that contains built-in rule types like `.string`, `.integer`, `.boolean`, and many others.

```swift
await FormCraftValidationRules()
  .string()
  .notEmpty()
  .notEmpty()
  .email()
  .optional()
  .validate(value: "test@gmail.com")
```

::: info RULE EXECUTION ORDER
Validation rules are executed from top to bottom, with one exception — `.optional()`.  
In this example, the execution order will be: `.optional()` → `.string()` → `.empty()` → `.email()`.

The `.optional()` method is special because it transforms the value into an `Optional`.
This method always runs first to avoid unnecessary validations — if the value is `nil`, the rest of the rules are skipped.

Also, if any rule fails, the remaining rules are not executed.  
Each rule can modify the value as it goes. For example, `.string().trim()` can remove spaces before passing it to `.trimmed()`.
:::

## The `.validate(value: Any?)` and `.validate(raw: Value)` methods

All validation rules provide two method signatures:

```swift
func validate(raw: Any?) async -> FormCraftValidationResponse<Value>
func validate(value: Value) async -> FormCraftValidationResponse<Value>
```

The generic type `Value` is inferred based on the rule you're using.
For example, `.string()` gives `String`, `.integer()` gives `Int`, etc.

If you don’t know the exact type at runtime or want to cast dynamically, use the `raw: Any?` version.

The `validate` method returns a `FormCraftValidationResponse<Value>` enum:
- `.success(value: Value)` — validation passed
- `.error(message: String)` — validation failed

::: info
The `validate` method is asynchronous.
:::

## Extending with custom rules

Most real-world projects need custom validation logic.
You can extend existing rule types or create entirely new ones.

### Adding a custom rule to an existing type (e.g., `.string`)

Let’s say you want to check if an email already exists in your backend.  
Since email is a string, we can extend the `FormCraftStringValidation` validator:

```swift
extension FormCraftStringValidation {
  func checkDuplicateEmail(message: String = "Email already exists") -> Self {
    var copySelf = self

    copySelf.rules.append { value in
      let isFreeEmail = await self.checkDuplicateEmailServer(email: value)

      if (!isFreeEmail) {
        return .error(message: message)
      }

      return .success(value: value)
    }

    return copySelf
  }

  private func checkDuplicateEmailServer(email: String) async -> Bool {
      // Call your backend
      return true
  }
}
```

You can now use this custom rule just like any built-in one:

```swift
let result = await FormCraftValidationRules()
  .string()
  .notEmpty()
  .email()
  .checkDuplicateEmail()
  .optional()
  .validate(value: "test@gmail.com")

switch result {
case .error(let errorMessage):
  print(errorMessage)
case .success(let value):
  print(value)
}
```

This also demonstrates the benefit of sequential validation:
If the `.email()` rule fails, the `.checkDuplicateEmail()` rule won’t run — saving you from an unnecessary API call.

### Adding a new custom type with rules

You can define completely new rule types for complex data.
For example, let’s say you want to validate a `User` struct:

```swift
struct User {
  let firstName: String
  let lastName: String
  let age: Int
}

extension FormCraftValidationRules {
  func userValidation() -> UserValidation {
    .init()
  }
}

struct UserValidation: FormCraftValidationTypeRules {
  var rules: [(_ value: User) async -> FormCraftValidationResponse<User>] = []

  func checkAge(message: String = "You must be over 21") async -> Self {
    var copySelf = self

    copySelf.rules.append { value in
      if (value.age < 21) {
          return .error(message: message)
      }

      return .success(value: value)
    }

    return copySelf
  }

  func checkFirstName(message: String = "First name must be longer than 6 characters.") async -> Self {
    var copySelf = self

    copySelf.rules.append { value in
      if (value.firstName.count < 6) {
        return .error(message: message)
      }

      return .success(value: value)
    }

    return copySelf
  }

  // Other rules...
}
```

Now you can use your custom validator like this:

```swift
await FormCraftValidationRules()
  .userValidation()
  .checkAge()
  .checkFirstName()
  .validate(value: user)
```
