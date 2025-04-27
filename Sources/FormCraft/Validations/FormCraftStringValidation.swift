//
//  FormCraftStringValidation.swift
//  FormCraft
//
//  Created by Артем Дробышев on 20.02.2025.
//

import Foundation

public extension FormCraftValidationRules {
    func string() -> FormCraftStringValidation {
        .init()
    }
}

public struct FormCraftStringValidation: FormCraftValidationTypeRules {
    public var rules: [(_ value: String) -> FormCraftValidationResponse<String>] = []

    public func isNotEmpty(message: String = "Value required") -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if value.isEmpty {
                return .error(message: message)
            }

            return .success(value: value)
        }

        return copySelf
    }

    public func email(message: String = "Value must be a valid email") -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            // swiftlint:disable line_length
            let pattern = #"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"#
            // swiftlint:enable line_length

            let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)

            guard predicate.evaluate(with: value) else {
                return .error(message: message)
            }

            return .success(value: value)
        }

        return copySelf
    }

    public func phoneNumber(message: String = "Value must be a valid phone number") -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            let pattern = #"^\+?[0-9]{7,15}$"#
            let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)

            guard predicate.evaluate(with: value) else {
                return .error(message: message)
            }

            return .success(value: value)
        }

        return copySelf
    }

    public func equalTo(to: String, message: String = "Values ​​do not match") -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if value != to {
                return .error(message: message)
            }

            return .success(value: value)
        }

        return copySelf
    }

    public func minLength(
        min: Int,
        message: String = "Value must be at least %@ characters"
    ) -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if value.count < min {
                return .error(message: String(format: message, "\(min)"))
            }

            return .success(value: value)
        }

        return copySelf
    }

    public func maxLength(
        max: Int,
        message: String = "Value must not be more than %@"
    ) -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            if value.count > max {
                return .error(message: String(format: message, "\(max)"))
            }

            return .success(value: value)
        }

        return copySelf
    }
}
