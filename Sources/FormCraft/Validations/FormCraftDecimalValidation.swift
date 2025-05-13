import Foundation

public extension FormCraftValidationRules {
    func decimal() -> FormCraftDecimalValidation {
        .init()
    }
}

public struct FormCraftDecimalValidation: FormCraftValidationTypeRules {
    public var rules: [(_ value: Decimal) async -> FormCraftValidationResponse<Decimal>] = []

    /// Add validation check that value strictly greater than `num`
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

    /// Add validation check that value greater than or equal to `num`
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

    /// Add validation check that value strictly less than `num`
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

    /// Add validation check that value less than or equal to `num`
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

    /// Add validation check that value is positive
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

    /// Add validation check that value is positive or zero
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

    /// Add validation check that value is negative
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

    /// Add validation check that value is negative or zero
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

    /// Add validation check that value is evenly divisible by `mult`
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
