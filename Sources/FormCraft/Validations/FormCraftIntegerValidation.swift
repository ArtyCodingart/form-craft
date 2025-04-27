//
//  FormCraftIntegerValidation.swift
//  FormCraft
//
//  Created by Артем Дробышев on 27.03.2025.
//

import Foundation

public extension FormCraftValidationRules {
    func integer() -> FormCraftIntegerValidation {
        .init()
    }
}

public struct FormCraftIntegerValidation: FormCraftValidationTypeRules {
    public var rules: [(_ value: Int) -> FormCraftValidationResponse<Int>] = []

    public func min(
        min: Int,
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
        max: Int,
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
