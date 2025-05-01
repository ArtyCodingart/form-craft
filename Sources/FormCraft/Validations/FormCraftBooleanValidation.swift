public extension FormCraftValidationRules {
    func boolean() -> FormCraftBooleanValidation {
        .init()
    }
}

public struct FormCraftBooleanValidation: FormCraftValidationTypeRules {
    public var rules: [(_ value: Bool) async -> FormCraftValidationResponse<Bool>] = []

    public func isTrue(message: String = "Value required") -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if !value {
                return .error(message: message)
            }

            return .success(value: value)
        }

        return copySelf
    }
}
