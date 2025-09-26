import Foundation

public extension FormCraftValidationRules {
    /// Creates a validation builder for `Decimal` values.
    ///
    /// - Returns: A decimal validation builder for chaining rules.
    func decimal() -> FormCraftDecimalValidation {
        .init()
    }
}

/// A validation builder for `Decimal` values that supports composing multiple rules.
public struct FormCraftDecimalValidation: FormCraftValidationTypeRules {
    public var rules: [(_ value: Decimal) async -> FormCraftValidationResponse<Decimal>] = []

    /// Validates that the value is strictly greater than the specified number.
    ///
    /// - Parameters:
    ///   - num: The exclusive lower bound.
    ///   - message: The error message returned when the value is not greater than `num`.
    /// - Returns: The validation builder for chaining.
    public func gt(
        num: Decimal,
        message: String = "Must be greater than %@"
    ) -> Self {
        addRule { value in
            if value <= num {
                return .error(message: String(format: message, "\(num)"))
            }

            return .success(value: value)
        }
    }

    /// Validates that the value is greater than or equal to the specified number.
    ///
    /// - Parameters:
    ///   - num: The inclusive lower bound.
    ///   - message: The error message returned when the value is less than `num`.
    /// - Returns: The validation builder for chaining.
    public func gte(
        num: Decimal,
        message: String = "Must be at least %@"
    ) -> Self {
        addRule { value in
            if value < num {
                return .error(message: String(format: message, "\(num)"))
            }

            return .success(value: value)
        }
    }

    /// Validates that the value is strictly less than the specified number.
    ///
    /// - Parameters:
    ///   - num: The exclusive upper bound.
    ///   - message: The error message returned when the value is not less than `num`.
    /// - Returns: The validation builder for chaining.
    public func lt(
        num: Decimal,
        message: String = "Must be less than %@"
    ) -> Self {
        addRule { value in
            if value >= num {
                return .error(message: String(format: message, "\(num)"))
            }

            return .success(value: value)
        }
    }

    /// Validates that the value is less than or equal to the specified number.
    ///
    /// - Parameters:
    ///   - num: The inclusive upper bound.
    ///   - message: The error message returned when the value is greater than `num`.
    /// - Returns: The validation builder for chaining.
    public func lte(
        num: Decimal,
        message: String = "Must not be more than %@"
    ) -> Self {
        addRule { value in
            if value > num {
                return .error(message: String(format: message, "\(num)"))
            }

            return .success(value: value)
        }
    }

    /// Validates that the value is positive (greater than zero).
    ///
    /// - Parameter message: The error message returned when the value is not positive.
    /// - Returns: The validation builder for chaining.
    public func positive(
        message: String = "Must be positive"
    ) -> Self {
        addRule { value in
            if value <= 0 {
                return .error(message: String(format: message))
            }

            return .success(value: value)
        }
    }

    /// Validates that the value is zero or positive.
    ///
    /// - Parameter message: The error message returned when the value is negative.
    /// - Returns: The validation builder for chaining.
    public func nonNegative(
        message: String = "Must not be negative"
    ) -> Self {
        addRule { value in
            if value < 0 {
                return .error(message: String(format: message))
            }

            return .success(value: value)
        }
    }

    /// Validates that the value is negative (less than zero).
    ///
    /// - Parameter message: The error message returned when the value is not negative.
    /// - Returns: The validation builder for chaining.
    public func negative(
        message: String = "Must be negative"
    ) -> Self {
        addRule { value in
            if value >= 0 {
                return .error(message: String(format: message))
            }

            return .success(value: value)
        }
    }

    /// Validates that the value is zero or negative.
    ///
    /// - Parameter message: The error message returned when the value is positive.
    /// - Returns: The validation builder for chaining.
    public func nonPositive(
        message: String = "Must not be positive"
    ) -> Self {
        addRule { value in
            if value > 0 {
                return .error(message: String(format: message))
            }

            return .success(value: value)
        }
    }

    /// Validates that the value is evenly divisible by the specified multiplier.
    ///
    /// - Parameters:
    ///   - mult: The multiplier (divisor). If zero, validation fails.
    ///   - message: The error message returned when the value is not a multiple of `mult`.
    /// - Returns: The validation builder for chaining.
    public func multipleOf(
        mult: Decimal,
        message: String = "Must be a multiple of %@"
    ) -> Self {
        addRule { value in
            guard mult != 0 else {
                return .error(message: String(format: message, "\(value)"))
            }

            let quotient = value / mult
            let truncated = Decimal(Double(trunc(Double(truncating: quotient as NSNumber))))

            if value - (mult * truncated) != 0 {
                return .error(message: String(format: message, "\(value)"))
            }

            return .success(value: value)
        }
    }
}
