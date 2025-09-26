public extension FormCraftValidationRules {
    /// Creates a validation builder for a custom value type.
    ///
    /// Use this to build rules for any type that conforms to `Sendable`.
    ///
    /// - Returns: A custom type validation builder for chaining rules.
    func customType<CustomType>() -> FormCraftCustomTypeValidation<CustomType> {
        .init()
    }
}

/// A validation builder for arbitrary value types.
public struct FormCraftCustomTypeValidation<CustomType: Sendable>: FormCraftValidationTypeRules {
    public var rules: [(_ value: CustomType) async -> FormCraftValidationResponse<CustomType>] = []
}
