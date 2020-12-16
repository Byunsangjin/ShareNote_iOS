//
//  User.swift
//  ShareNote
//
//  Created by sjbyun on 2020/12/14.
//

import Foundation

// MARK: - Welcome
struct Welcome: Decodable {
    let embedded: Embedded
    let links: Links

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case links = "_links"
    }
}

// MARK: - Embedded
struct Embedded: Codable {
    let memberList: [MemberList]
}

// MARK: - MemberList
struct MemberList: Codable {
    let mbrID, mbrPwd: String
    let mbrName, mbrEmail, mbrUUID: String?
    let mbrType, mbrPhoneNum: String
    let mbrGrade: String?
    let mbrState: Int?
    let mbrUseYn: Bool?
    let mbrUdtDate: String?
    let mbrRegDate: String?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case mbrID = "mbrId"
        case mbrPwd, mbrName, mbrEmail
        case mbrUUID = "mbrUuid"
        case mbrType, mbrPhoneNum, mbrGrade, mbrState, mbrUseYn, mbrUdtDate, mbrRegDate
        case links = "_links"
    }
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: SelfClass

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - SelfClass
struct SelfClass: Codable {
    let href: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
