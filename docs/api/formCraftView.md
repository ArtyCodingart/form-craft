# FormCraftView <Badge type="tip" text="Struct" />

`FormCraftView` is a lightweight container for form content.
It accepts a form config object and renders custom SwiftUI layout.

## Constructor

```swift
init(
    formConfig: FormConfig,
    @ViewBuilder content: () -> Content
)
```

### Arguments
- **`formConfig: FormConfig`** - form configuration object (`FormCraft` or custom type conforming to `FormCraftConfig`).
- **`content`** - form content builder.

Example:

```swift
FormCraftView(formConfig: form) {
    FormCraftControllerView(formConfig: form, key: \.email) { value, _ in
        TextField("Email", text: value)
    }
}
```
