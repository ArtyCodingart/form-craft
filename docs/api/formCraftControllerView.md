# FormCraftControllerView
`FormCraftControllerView` - это SwiftUI-компонент для связывания элементов интерфейса с полями формы.  

## Constructor

```swift
init<Field: FormCraftFieldConfigurable>(
    form: FormCraft<Fields>,
    keyPath: WritableKeyPath<Fields, Field>,
    @ViewBuilder content: @escaping (Binding<Field.Value>, String?) -> Content
)
```

### Arguments
- **`form: FormCraft<Fields>`** - экземпляр формы, управляющий состоянием.  
- **`keyPath: WritableKeyPath<Fields, Field>`** - ссылка на конкретное поле формы.  
- **`content`** - вью-билдер, принимающий биндинг к значению поля и возможное сообщение об ошибке.  
