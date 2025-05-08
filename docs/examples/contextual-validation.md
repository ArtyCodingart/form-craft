# Contextual Validation

In some cases it might be required to validate one field
based on value of another field, there is example how to achieve it.

```swift
private struct PaymentFormFields: FormCraftFields {
  var paymentOption = FormCraftField<PaymentOption?, PaymentOption>(
    name: "paymentOption",
    value: nil
  ) { value in
    FormCraftValidationRules()
      .customType()
      validate(raw: value)
  }

  var amount = FormCraftField<Decimal?, Decimal>(
    name: "amount",
    value: nil
  ) { value in
    FormCraftValidationRules()
      .decimal()
      .validate(raw: value)
  }

  func refine(form: FormCraft<Self>) -> [FormCraft<Self>.Key, String?] {
    guard let paymentOption = self.paymentOption.value else {
      return [:]
    }

    return [
      \.amount: FormCraftValidationRules()
        .decimal()
        .lte(num: paymentOption.maxAmount)
        .gte(num: paymentOption.minAmount)
        .optional()
        .validate(value: amount.value)
        .errorMessage
    ]
  }
}
```
