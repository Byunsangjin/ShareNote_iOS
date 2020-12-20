//
//  User.swift
//  ShareNote
//
//  Created by sjbyun on 2020/12/20.
//
/**
 유저 관련 Model
 */
import Foundation

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
