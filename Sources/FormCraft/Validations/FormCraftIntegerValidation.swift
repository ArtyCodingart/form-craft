import Foundation

public extension FormCraftValidationRules {
    func integer() -> FormCraftIntegerValidation {
        .init()
    }
}

public struct FormCraftIntegerValidation: FormCraftValidationTypeRules {
    public var rules: [(_ value: Int) -> FormCraftValidationResponse<Int>] = []

    /// Add validation check that value strictly greater than `num`
    public func gt(
        num: Int,
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
        num: Int,
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
        num: Int,
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
        num: Int,
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
    public func isPositive(
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
    public func isNonNegative(
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
    public func isNegative(
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
    public func isNonPositive(
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
        num: Int,
        message: String = "Value must be a multiple of %@"
    ) -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if num == 0 || value % num != 0 {
                return .error(message: String(format: message, "\(num)"))
            }

            return .success(value: value)
        }

        return copySelf
    }
}
