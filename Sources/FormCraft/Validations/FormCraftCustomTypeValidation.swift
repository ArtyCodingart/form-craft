public extension FormCraftValidationRules {
    func customType<CustomType>() -> FormCraftCustomTypeValidation<CustomType> {
        .init()
    }
}

public struct FormCraftCustomTypeValidation<CustomType: Sendable>: FormCraftValidationTypeRules {
    public var rules: [(_ value: CustomType) async -> FormCraftValidationResponse<CustomType>] = []
}
