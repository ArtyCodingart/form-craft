public extension FormCraftValidationTypeRules {
    func optional() -> FormCraftOptionalValidation<Self> {
        .init(base: self)
    }
}

public struct FormCraftOptionalValidation<Base: FormCraftValidationTypeRules>: FormCraftValidationTypeRules {
    public typealias Value = Base.Value?

    public var rules: [(Value) async -> FormCraftValidationResponse<Value>] = []

    public let base: Base

    public func validate(value: Value) async -> FormCraftValidationResponse<Value> {
        if let value {
            let result = await base.validate(value: value)

            switch result {
            case .success(let value):
                return .success(value: value)
            case .error(let message):
                return .error(message: message)
            }
        }

        return .success(value: value)
    }
}
