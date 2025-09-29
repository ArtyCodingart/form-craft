# FormCraftFields
`FormCraftFields` - is a protocol for describing a set of form fields.  
Each structure with fields must implement it in order to work with `FormCraft`.  
The protocol also allows defining global validation at the form level.  

## Constructor

The protocol has no constructor.  
Fields are defined inside structures that implement `FormCraftFields`.  

## Properties

The protocol itself has no properties.  
Properties are defined in concrete structures and are usually instances of `FormCraftField`.  

## Methods

### refine

```swift
@MainActor
func refine(form: FormCraft<Self>) async -> [FormCraft<Self>.Key: String?]
```

- Performs validation at the form level.  
- Returns a dictionary of errors, where the key is the field and the value is the error message or `nil`.  
