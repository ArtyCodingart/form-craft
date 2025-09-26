import Foundation

public extension FormCraftValidationRules {
    /// Creates a validation builder for `Int` values.
    ///
    /// - Returns: An integer validation builder for chaining rules.
    func integer() -> FormCraftIntegerValidation {
        .init()
    }
}

/// A validation builder for `Int` values that supports composing multiple rules.
public struct FormCraftIntegerValidation: FormCraftValidationTypeRules {
    public var rules: [(_ value: Int) async -> FormCraftValidationResponse<Int>] = []

    /// Validates that the value is strictly greater than the specified number.
    ///
    /// - Parameters:
    ///   - num: The exclusive lower bound.
    ///   - message: The error message returned when the value is not greater than `num`.
    /// - Returns: The validation builder for chaining.
    public func gt(
        num: Int,
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
        num: Int,
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
        num: Int,
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
        num: Int,
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

    /// Validates that the value is evenly divisible by the specified number.
    ///
    /// - Parameters:
    ///   - num: The divisor. If zero, validation fails.
    ///   - message: The error message returned when the value is not a multiple of `num`.
    /// - Returns: The validation builder for chaining.
    public func multipleOf(
        num: Int,
        message: String = "Must be a multiple of %@"
    ) -> Self {
        addRule { value in
            if num == 0 || value % num != 0 {
                return .error(message: String(format: message, "\(num)"))
            }

            return .success(value: value)
        }
    }
}
