public protocol FormCraftValidationTypeRules {
    associatedtype Value: Sendable

    var rules: [(_ value: Value) -> FormCraftValidationResponse<Value>] { get set }

    func validate(value: Value) -> FormCraftValidationResponse<Value>
}

public extension FormCraftValidationTypeRules {
    func validate(raw: Any?) -> FormCraftValidationResponse<Value> {
        guard let typed = raw as? Value else {
            if raw == nil {
                return .error(message: "Value required")
            }

            return .error(message:
                "Invalid type: expected \(Value.self), received \(type(of: raw))"
            )
        }

        return validate(value: typed)
    }

    func validate(value: Value) -> FormCraftValidationResponse<Value> {
        var modifyValue = value

        for rule in rules {
            let validated = rule(modifyValue)

            switch validated {
            case .success(let successValue):
                modifyValue = successValue
            case .error(let message):
                return .error(message: message)
            }
        }

        return .success(value: modifyValue)
    }
}

public struct FormCraftValidationRules {
    public init() {}
}
