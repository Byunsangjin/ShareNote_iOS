//
//  User.swift
//  ShareNote
//
//  Created by sjbyun on 2020/12/14.
//

import Foundation

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
