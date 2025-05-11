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
        message: String = "Value must be greater than %@"
    ) -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if value <= num {
                return .error(message: String(format: message, "\(num)"))
            }

            return .success(value: value)
        }


        return copySelf
    }

    /// Add validation check that value greater than or equal to `num`
    public func gte(
        num: Decimal,
        message: String = "Value must be at least %@"
    ) -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if value < num {
                return .error(message: String(format: message, "\(num)"))
            }

            return .success(value: value)
        }


        return copySelf
    }

    /// Add validation check that value strictly less than `num`
    public func lt(
        num: Decimal,
        message: String = "Value must be less than %@"
    ) -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if value >= num {
                return .error(message: String(format: message, "\(num)"))
            }

            return .success(value: value)
        }

        return copySelf
    }

    /// Add validation check that value less than or equal to `num`
    public func lte(
        num: Decimal,
        message: String = "Value must not be more than %@"
    ) -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if value > num {
                return .error(message: String(format: message, "\(num)"))
            }

            return .success(value: value)
        }

        return copySelf
    }

    /// Add validation check that value is positive
    public func positive(
        message: String = "Value must be positive"
    ) -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if value <= 0 {
                return .error(message: String(format: message))
            }

            return .success(value: value)
        }

        return copySelf
    }

    /// Add validation check that value is positive or zero
    public func nonNegative(
        message: String = "Value must not be negative"
    ) -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if value < 0 {
                return .error(message: String(format: message))
            }

            return .success(value: value)
        }

        return copySelf
    }

    /// Add validation check that value is negative
    public func negative(
        message: String = "Value must be negative"
    ) -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if value >= 0 {
                return .error(message: String(format: message))
            }

            return .success(value: value)
        }

        return copySelf
    }

    /// Add validation check that value is negative or zero
    public func nonPositive(
        message: String = "Value must not be positive"
    ) -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if value > 0 {
                return .error(message: String(format: message))
            }

            return .success(value: value)
        }

        return copySelf
    }

    /// Add validation check that value is evenly divisible by `num`
    public func multipleOf(
        num: Decimal,
        message: String = "Value must be a multiple of %@"
    ) -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            guard mult != 0 else {
                return .error(message: String(format: message, "\(num)"))
            }

            let quotient = num / mult
            let truncated = Decimal(Double(trunc(Double(truncating: quotient as NSNumber))))

            if num - (mult * truncated) != 0 {
                return .error(message: String(format: message, "\(num)"))
            }

            return .success(value: value)
        }

        return copySelf
    }
}
