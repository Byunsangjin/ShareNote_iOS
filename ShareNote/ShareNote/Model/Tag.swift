//
//  Tag.swift
//  ShareNote
//
//  Created by sjbyun on 2020/12/22.
//

/**
 태그 관련 Model
 */

import Foundation

// MARK: - Tag
struct Tag: Codable {
    let tagSeq: Int?
    let tagName: String
    let tagUseYn: Bool?
    let tagUdtDate: String?
    let tagRegDate: String?
}
