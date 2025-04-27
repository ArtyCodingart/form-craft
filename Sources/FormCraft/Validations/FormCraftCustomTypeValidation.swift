//
//  FormCraftStructValidation.swift
//  FormCraft
//
//  Created by Артем Дробышев on 22.04.2025.
//

public extension FormCraftValidationRules {
    func customType<CustomType>() -> FormCraftCustomTypeValidation<CustomType> {
        .init()
    }
}

public struct FormCraftCustomTypeValidation<CustomType: Sendable>: FormCraftValidationTypeRules {
    public var rules: [(_ value: CustomType) -> FormCraftValidationResponse<CustomType>] = []
}
