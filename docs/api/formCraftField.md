# FormCraftField
`FormCraftField` - is a universal structure for describing a single form field.  
It stores the current value, the field name, validation rules, and settings for the field.  
It is used inside structures that implement `FormCraftFields`.  

## Constructor

```swift
init(
    name: String,
    value: Value,
    delayValidation: FormCraftDelayValidation = .immediate,
    rule: @escaping (_ value: Value) async -> FormCraftValidationResponse<ValidatedValue>
)
```

### Arguments
- **`name: String`** - the field name, used for identification and must be unique.  
- **`value: Value`** - the current value of the field.  
- **`delayValidation: FormCraftDelayValidation`** - the delay before starting validation (default is `.immediate`).  
- **`rule`** - an asynchronous validation rule. Takes the value and returns the validation result.  

## Properties

- **`name: String`** - the field name.  
- **`value: Value`** - the current value of the field.  
- **`delayValidation: FormCraftDelayValidation`** - the validation delay for this field.  
- **`rule`** - the function for validating the value.  

## Methods

### validate

```swift
func validate() async -> (ValidatedValue?, String?)
```

- Runs validation of the current field value.  
- Returns a tuple:  
  - the validated value or `nil`;  
  - the error message or `nil`.  
