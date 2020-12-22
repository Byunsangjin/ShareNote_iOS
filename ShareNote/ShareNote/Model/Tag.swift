//
//  Tag.swift
//  ShareNote
//
//  Created by sjbyun on 2020/12/22.
//

import Foundation

// MARK: - Tag
struct Tag: Codable {
    let tagSeq: Int?
    let tagName: String
    let tagUseYn: Bool?
    let tagUdtDate: String?
    let tagRegDate: String?
}
