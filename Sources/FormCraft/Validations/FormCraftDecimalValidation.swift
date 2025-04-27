//
//  FormCraftDecimalValidation.swift
//  FormCraft
//
//  Created by Артем Дробышев on 14.04.2025.
//

import Foundation

public extension FormCraftValidationRules {
    func decimal() -> FormCraftDecimalValidation {
        .init()
    }
}

public struct FormCraftDecimalValidation: FormCraftValidationTypeRules {
    public var rules: [(_ value: Decimal) -> FormCraftValidationResponse<Decimal>] = []

    public func min(
        min: Decimal,
        message: String = "Value must be at least %@"
    ) -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if value < min {
                return .error(message: String(format: message, "\(min)"))
            }

            return .success(value: value)
        }


        return copySelf
    }

    public func max(
        max: Decimal,
        message: String = "Value must not be more than %@"
    ) -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if value > max {
                return .error(message: String(format: message, "\(max)"))
            }

            return .success(value: value)
        }

        return copySelf
    }
}

