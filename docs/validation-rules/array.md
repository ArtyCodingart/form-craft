# Array

FormCraft does not provide a dedicated `.array()` rule builder.

To validate arrays, use `customType<[Element]>()` and define your own rules.

## Example

```swift
let tagsValidation = FormCraftValidationRules()
  .customType<[String]>()
  .addRule { tags in
    if tags.isEmpty {
      return .failure(errors: .init(["At least one tag is required"]))
    }

    return .success(value: tags)
  }
  .addRule { tags in
    if tags.count > 10 {
      return .failure(errors: .init(["No more than 10 tags are allowed"]))
    }

    return .success(value: tags)
  }

let result = await tagsValidation.validate(value: ["swift", "ios"])
```
