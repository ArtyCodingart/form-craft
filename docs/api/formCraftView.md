# FormCraftView
`FormCraftView` - это SwiftUI-компонент для отображения и управления формой.  
Он принимает экземпляр `FormCraft` и с помощью `@ViewBuilder` позволяет описать, как должны выглядеть поля и элементы управления.  

## Constructor

```swift
init<Content: View>(
    form: FormCraft<Fields>,
    @ViewBuilder content: @escaping (FormCraft<Fields>) -> Content
)
```

### Arguments
- **`form: FormCraft<Fields>`** - экземпляр формы, управляющий состоянием.  
- **`content`** - вью-билдер, который принимает форму и возвращает её разметку.  
