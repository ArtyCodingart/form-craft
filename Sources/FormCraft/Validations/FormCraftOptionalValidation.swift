//
//  FormCraftValidationOptional.swift
//  FormCraft
//
//  Created by Артем Дробышев on 27.03.2025.
//

public extension FormCraftValidationTypeRules {
    func optional() -> OptionalValidator<Self> {
        .init(base: self)
    }
}

public struct OptionalValidator<Base: FormCraftValidationTypeRules>: FormCraftValidationTypeRules {
    public typealias Value = Base.Value?

    public var rules: [(Value) -> FormCraftValidationResponse<Value>] = []

    public let base: Base

    public func validate(value: Value) -> FormCraftValidationResponse<Value> {
        if let value {
            let result = base.validate(value: value)

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
