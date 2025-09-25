import Foundation

public extension FormCraftValidationRules {
    func string() -> FormCraftStringValidation {
        .init()
    }
}

public struct FormCraftStringValidation: FormCraftValidationTypeRules {
    public var rules: [(_ value: String) async -> FormCraftValidationResponse<String>] = []

    public init() {}

    /// Add validation check that value is not empty
    public func notEmpty(message: String = "Must not be empty") -> Self {
        addRule { value in
            if value.isEmpty {
                return .error(message: message)
            }

            return .success(value: value)
        }
    }

    /// Add validation check that value does not contains whitespace characters on start/end
    /// https://en.wikipedia.org/wiki/Whitespace_character
    public func trimmed(message: String = "Must not start or end with whitespace characters") -> Self {
        addRule { value in
            let t = value.trimmingCharacters(in: .whitespacesAndNewlines)

            return (t == value) ? .success(value: value) : .error(message: message)
        }
    }

    /// Add validation check that value is valid CUID
    public func cuid(message: String = "Must be valid CUID") -> Self {
        addRule { value in
            let pattern = /^c[^\s-]{8,}$/
            let isMatch = (try? pattern.wholeMatch(in: value)) != nil

            guard isMatch else {
                return .error(message: message)
            }

            return .success(value: value)
        }
    }

    /// Add validation check that value is valid CUID2
    public func cuid2(message: String = "Must be valid CUID2") -> Self {
        addRule { value in
            let pattern = /^[0-9a-z]+$/
            let isMatch = (try? pattern.wholeMatch(in: value)) != nil

            guard isMatch else {
                return .error(message: message)
            }

            return .success(value: value)
        }
    }

    /// Add validation check that value is valid ULID
    public func ulid(message: String = "Must be valid ULID") -> Self {
        addRule { value in
            let pattern = /^[0-9A-HJKMNP-TV-Z]{26}$/
            let isMatch = (try? pattern.wholeMatch(in: value)) != nil

            guard isMatch else {
                return .error(message: message)
            }

            return .success(value: value)
        }
    }

    /// Add validation check that value is valid UUID
    public func uuid(message: String = "Must be valid UUID") -> Self {
        addRule { value in
            // swiftlint:disable line_length
            let pattern = /^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$/
            // swiftlint:enable line_length
            let isMatch = (try? pattern.wholeMatch(in: value)) != nil

            guard isMatch else {
                return .error(message: message)
            }

            return .success(value: value)
        }
    }

    /// Add validation check that value is valid ULID
    public func nanoId(message: String = "Must be valid NanoID") -> Self {
        addRule { value in
            let pattern = /^[a-z0-9_-]{21}$/
            let isMatch = (try? pattern.wholeMatch(in: value)) != nil

            guard isMatch else {
                return .error(message: message)
            }

            return .success(value: value)
        }
    }

    /// Add validation check that value is valid IPv4
    public func ipv4(message: String = "Invalid IPv4 address") -> Self {
        addRule { value in
            // swiftlint:disable line_length
            let pattern = /^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$/
            // swiftlint:enable line_length
            let isMatch = (try? pattern.wholeMatch(in: value)) != nil

            guard isMatch else {
                return .error(message: message)
            }

            return .success(value: value)
        }
    }

    /// Add validation check that value is valid IPv4
    private func ipv4cidr(message: String = "Must be correct IPv4 cidr") -> Self {
        addRule { value in
            // swiftlint:disable line_length
            let pattern = /^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$/
            // swiftlint:enable line_length
            let isMatch = (try? pattern.wholeMatch(in: value)) != nil

            guard isMatch else {
                return .error(message: message)
            }

            return .success(value: value)
        }
    }

    /// Add validation check that value is valid IPv6
    public func ipv6(message: String = "Invalid IPv6 address") -> Self {
        addRule { value in
            // swiftlint:disable line_length
            let pattern = /^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$/
            // swiftlint:enable line_length
            let isMatch = (try? pattern.wholeMatch(in: value)) != nil

            guard isMatch else {
                return .error(message: message)
            }

            return .success(value: value)
        }
    }

    /// Add validation check that value is valid IPv6 CIDR
    private func ipv6cidr(message: String = "Must be correct IPv6 cidr") -> Self {
        addRule { value in
            // swiftlint:disable line_length
            let pattern = /^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$/
            // swiftlint:enable line_length
            let isMatch = (try? pattern.wholeMatch(in: value)) != nil

            guard isMatch else {
                return .error(message: message)
            }

            return .success(value: value)
        }
    }

    /// Add validation check that value is valid CIDR
    /// TODO Need to fix
    public func cidr(message: String = "Must be correct CIDR") -> Self {
        return ipv4cidr(message: message)
            .ipv6cidr(message: message)
    }

    /// Add validation check that value is valid IP
    /// TODO Need to fix
    public func ip(message: String = "Invalid IP address") -> Self {
        return ipv4cidr(message: message)
            .ipv6cidr(message: message)
    }

    /// Add validation check that value is valid ISO date format (YYYY-MM-DD)
    private func date(message: String = "Must be correct date YYYY-MM-DD") -> Self {
        addRule { value in
            // swiftlint:disable line_length
            let pattern = /^((\d\d[2468][048]|\d\d[13579][26]|\d\d0[48]|[02468][048]00|[13579][26]00)-02-29|\d{4}-((0[13578]|1[02])-(0[1-9]|[12]\d|3[01])|(0[469]|11)-(0[1-9]|[12]\d|30)|(02)-(0[1-9]|1\d|2[0-8])))$/
            // swiftlint:enable line_length
            let isMatch = (try? pattern.wholeMatch(in: value)) != nil

            guard isMatch else {
                return .error(message: message)
            }

            return .success(value: value)
        }
    }

    /// Add validation check that value is valid email address
    public func email(message: String = "Invalid email address") -> Self {
        addRule { value in
            // swiftlint:disable line_length
            let pattern = #"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"#
            // swiftlint:enable line_length

            let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)

            guard predicate.evaluate(with: value) else {
                return .error(message: message)
            }

            return .success(value: value)
        }
    }

    /// Add validation check that value is looks like E.164 phone number
    /// https://en.wikipedia.org/wiki/E.164
    /// > Note that it is not check that phone number really correct.
    /// > If you want to correct phone number validation,
    /// > consider to using 3rd party library, throung custom rule.
    /// > Example: https://artycodingart.github.io/form-craft/examples/strong-phone-validation
    public func phoneNumber(message: String = "Must be a valid phone number") -> Self {
        addRule { value in
            let pattern = #"^\+?[0-9]{7,15}$"#
            let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)

            guard predicate.evaluate(with: value) else {
                return .error(message: message)
            }

            return .success(value: value)
        }
    }

    func regex(pattern: Regex<Substring>, message: String = "Value is not valid") -> Self {
        var copySelf = self

        copySelf.rules.append { value in
            let isMatches = (try? pattern.wholeMatch(in: value)) != nil

            guard isMatches else {
                return .error(message: message)
            }

            return .success(value: value)
        }

        return copySelf
    }

    /// Add validation check that user input value is equals to provided value
    public func equals(to: String, message: String = "Values doesn't not match") -> Self {
        addRule { value in
            if value != to {
                return .error(message: message)
            }

            return .success(value: value)
        }
    }

    /// Add validation check that value is at least `min` characters length
    public func minLength(
        min: Int,
        message: String = "Must be %@ or more characters long"
    ) -> Self {
        addRule { value in
            if value.count < min {
                return .error(message: String(format: message, "\(min)"))
            }

            return .success(value: value)
        }
    }

    /// Add validation check that value is at most `max` characters length
    public func maxLength(
        max: Int,
        message: String = "Must be %@ or fewer characters long"
    ) -> Self {
        addRule { value in
            if value.count > max {
                return .error(message: String(format: message, "\(max)"))
            }

            return .success(value: value)
        }
    }
}
