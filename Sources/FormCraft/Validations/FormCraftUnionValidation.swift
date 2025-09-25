//
//  FormCraftUnionValidation.swift
//  FormCraft
//
//  Created by Артем Дробышев on 05.09.2025.
//

import Foundation

public extension FormCraftValidationRules {
    func union<
        each Rule: FormCraftValidationTypeRules
    >(
        _ value: Any,
        _ rules: repeat each Rule
    ) async -> FormCraftValidationResponse<(repeat ((each Rule).Value)?)> {
        let results = await (repeat (each rules).validate(raw: value))

        var errorMessage = "Unexpected error in union validation"
        for result in repeat each results {
            switch result {
            case .success:
                return .success(value: (repeat (each results).value))
            case .error(let message):
                errorMessage = message
            }
        }

        return .error(message: errorMessage)
    }
}
