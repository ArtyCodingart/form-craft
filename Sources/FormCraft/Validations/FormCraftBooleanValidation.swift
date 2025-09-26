public extension FormCraftValidationRules {
    /// Creates a validation builder for `Bool` values.
    ///
    /// - Returns: A boolean validation builder for chaining rules.
    func boolean() -> FormCraftBooleanValidation {
        .init()
    }
}

/// A validation builder for `Bool` values that supports composing multiple rules.
public struct FormCraftBooleanValidation: FormCraftValidationTypeRules {
    public var rules: [(_ value: Bool) async -> FormCraftValidationResponse<Bool>] = []

    /// Validates that the value is `true`.
    ///
    /// This is commonly used for "Terms & Conditions" or "Consent" checkboxes.
    ///
    /// - Parameter message: The error message returned when the value is `false`.
    /// - Returns: The validation builder for chaining.
    public func checked(message: String = "Required") -> Self {
        addRule { value in
            if !value {
                return .error(message: message)
            }

            return .success(value: value)
        }
    }
}
