//
//  Category.swift
//  ShareNote
//
//  Created by sjbyun on 2020/12/20.
//

/**
 카테고리 관련 Model
 */

import Foundation

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
