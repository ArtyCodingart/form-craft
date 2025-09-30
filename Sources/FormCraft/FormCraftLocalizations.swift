//
//  FormCraftLocalizations.swift
//  FormCraft
//
//  Created by Артем Дробышев on 29.09.2025.
//

import SwiftUI

public struct FormCraftLocalizations {
    public var required: LocalizedStringResource
    public var gt: (String) -> LocalizedStringResource
    public var gte: (String) -> LocalizedStringResource
    public var lt: (String) -> LocalizedStringResource
    public var lte: (String) -> LocalizedStringResource
    public var positive: LocalizedStringResource
    public var nonNegative: LocalizedStringResource
    public var negative: LocalizedStringResource
    public var nonPositive: LocalizedStringResource
    public var multipleOf: (String) -> LocalizedStringResource
    public var trimmed: LocalizedStringResource
    public var cuid: LocalizedStringResource
    public var cuid2: LocalizedStringResource
    public var ulid: LocalizedStringResource
    public var uuid: LocalizedStringResource
    public var nanoId: LocalizedStringResource
    public var ipv4: LocalizedStringResource
    public var ipv6: LocalizedStringResource
    public var cidrv4: LocalizedStringResource
    public var cidrv6: LocalizedStringResource
    public var isoDate: LocalizedStringResource
    public var email: LocalizedStringResource
    public var e164phoneNumber: LocalizedStringResource
    public var regex: LocalizedStringResource
    public var equals: (String, String) -> LocalizedStringResource
    public var minLength: (String) -> LocalizedStringResource
    public var maxLength: (String) -> LocalizedStringResource
    public var length: (String) -> LocalizedStringResource

    public init(
        required: LocalizedStringResource? = nil,
        gt: ((String) -> LocalizedStringResource)? = nil,
        gte: ((String) -> LocalizedStringResource)? = nil,
        lt: ((String) -> LocalizedStringResource)? = nil,
        lte: ((String) -> LocalizedStringResource)? = nil,
        positive: LocalizedStringResource? = nil,
        nonNegative: LocalizedStringResource? = nil,
        negative: LocalizedStringResource? = nil,
        nonPositive: LocalizedStringResource? = nil,
        multipleOf: ((String) -> LocalizedStringResource)? = nil,
        trimmed: LocalizedStringResource? = nil,
        cuid: LocalizedStringResource? = nil,
        cuid2: LocalizedStringResource? = nil,
        ulid: LocalizedStringResource? = nil,
        uuid: LocalizedStringResource? = nil,
        nanoId: LocalizedStringResource? = nil,
        ipv4: LocalizedStringResource? = nil,
        ipv6: LocalizedStringResource? = nil,
        cidrv4: LocalizedStringResource? = nil,
        cidrv6: LocalizedStringResource? = nil,
        isoDate: LocalizedStringResource? = nil,
        email: LocalizedStringResource? = nil,
        e164phoneNumber: LocalizedStringResource? = nil,
        regex: LocalizedStringResource? = nil,
        equals: ((String, String) -> LocalizedStringResource)? = nil,
        minLength: ((String) -> LocalizedStringResource)? = nil,
        maxLength: ((String) -> LocalizedStringResource)? = nil,
        length: ((String) -> LocalizedStringResource)? = nil
    ) {
        self.required = required ?? .required
        self.gt = gt ?? { .gt($0) }
        self.gte = gte ?? { .gte($0) }
        self.lt = lt ?? { .lt($0) }
        self.lte = lte ?? { .lte($0) }
        self.positive = positive ?? .positive
        self.nonNegative = nonNegative ?? .nonNegative
        self.negative = negative ?? .negative
        self.nonPositive = nonPositive ?? .nonPositive
        self.multipleOf = multipleOf ?? { .multipleOf($0) }
        self.trimmed = trimmed ?? .trimmed
        self.cuid = cuid ?? .cuid
        self.cuid2 = cuid2 ?? .cuid2
        self.ulid = ulid ?? .ulid
        self.uuid = uuid ?? .uuid
        self.nanoId = nanoId ?? .nanoId
        self.ipv4 = ipv4 ?? .ipv4
        self.ipv6 = ipv6 ?? .ipv6
        self.cidrv4 = cidrv4 ?? .cidrv4
        self.cidrv6 = cidrv6 ?? .cidrv6
        self.isoDate = isoDate ?? .isoDate
        self.email = email ?? .email
        self.e164phoneNumber = e164phoneNumber ?? .e164PhoneNumber
        self.regex = regex ?? .regex
        self.equals = equals ?? { .equals($0, $1) }
        self.minLength = minLength ?? { .minLength($0) }
        self.maxLength = maxLength ?? { .maxLength($0) }
        self.length = length ?? { .length($0) }
    }
}
