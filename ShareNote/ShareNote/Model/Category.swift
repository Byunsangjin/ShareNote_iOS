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
struct Category: Codable {
    let ctgSeq: Int
    let ctgName: String
    let ctgPopularity: Int
    let ctgUseYn: Bool?
    let ctgUdtDate: String?
    let ctgRegDate: String?
    let links: Links?

    enum CodingKeys: String, CodingKey {
        case ctgSeq, ctgName, ctgPopularity, ctgUseYn, ctgUdtDate, ctgRegDate
        case links = "_links"
    }
}

//// MARK: - CategoryDetail
struct CategoryDetail: Codable {
    let category: Category
    let ctgDetailSeq, ctgDetailPopularity: Int?
    let ctgDetailName: String?
    let ctgDetailUseYn: Bool?
    let ctgDetailUdtDate: String?
    let ctgDetailRegDate: String?
}
