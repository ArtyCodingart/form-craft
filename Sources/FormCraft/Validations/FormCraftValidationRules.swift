public protocol FormCraftValidationTypeRules {
    associatedtype Value: Sendable

    typealias Rule = (_ value: Value) async -> FormCraftValidationResponse<Value>

    var rules: [Rule] { get set }

    func validate(value: Value) async -> FormCraftValidationResponse<Value>
}

public extension FormCraftValidationTypeRules {
    func validate(raw: Any?) async -> FormCraftValidationResponse<Value> {
        guard let typed = raw as? Value else {
            if raw == nil {
                return .error(message: "Value required")
            }

            return .error(message:
                "Invalid type: expected \(Value.self), received \(type(of: raw))"
            )
        }

        return await validate(value: typed)
    }

    func validate(value: Value) async -> FormCraftValidationResponse<Value> {
        var modifyValue = value

        for rule in rules {
            let validated = await rule(modifyValue)

            switch validated {
            case .success(let successValue):
                modifyValue = successValue
            case .error(let message):
                return .error(message: message)
            }
        }

        return .success(value: modifyValue)
    }

    func addRule(_ rule: @escaping Rule) -> Self {
        var copySelf = self
        
        copySelf.rules.append(rule)
        
        return copySelf
    }
}

public struct FormCraftValidationRules {
    public init() {}
}
