//
//  User.swift
//  ShareNote
//
//  Created by sjbyun on 2020/12/14.
//

import Foundation

// MARK: - User
struct JsonData: Decodable {
    let embedded: Embedded
    let links: Links

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case links = "_links"
    }
}

// MARK: - Embedded
struct Embedded: Codable {
    let memberList: [MemberList]?
    let categoryList: [CategoryList]?
    let categoryDetailList: [CategoryDetailList]?
    let categoryDTOList: [CategoryDTOList]?
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

struct User: Codable {
    let mbrID, mbrPwd: String
    let mbrName, mbrEmail, mbrUUID: String?
    let mbrType, mbrPhoneNum: String
    let mbrGrade: String?
    let mbrState: Int?
    let mbrUseYn: Bool?
    let mbrUdtDate: String?
    let mbrRegDate: String?
}

// MARK: - CategoryList
struct CategoryList: Codable {
    let ctgSeq: Int
    let ctgName: String
    let ctgUseYn: Bool
    let ctgUdtDate: String?
    let ctgRegDate: String
    let links: Links

    enum CodingKeys: String, CodingKey {
        case ctgSeq, ctgName, ctgUseYn, ctgUdtDate, ctgRegDate
        case links = "_links"
    }
}

// MARK: - CategoryDetailList
struct CategoryDetailList: Codable {
    let ctgDetailSeq: Int
    let category: Category
    let ctgDetailName: String
    let ctgDetailUseYn: Bool
    let ctgDetailUdtDate: String?
    let ctgDetailRegDate: String
}

// MARK: - Category
struct Category: Codable {
    let ctgSeq: Int
    let ctgName: String
    let ctgUseYn: Bool
    let ctgUdtDate: String?
    let ctgRegDate: String
}

// MARK: - CategoryDTOList
struct CategoryDTOList: Codable {
    let ctgSeq: Int
    let ctgName: String
    let ctgPopularity: Int
    let ctgDetailSeq: Int?
    let ctgDetailName: String?
    let ctgDetailPopularity: Int?
    let ctgIsCategory: Int
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
