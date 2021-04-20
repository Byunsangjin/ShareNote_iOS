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
struct Member: Codable {
    var mbrID, mbrPwd, mbrName, mbrEmail: String?
    var mbrUUID: String?
    var mbrType: String? = "normal"
    var mbrPhoneNum: String?
    var media, topic, bookmark: [String]?
    var mbrPoint: Int?
    var grade: Grade?
    var mbrGrade: String?
    var mbrState: Int?
    var mbrUseYn: Bool?
    var mbrUdtDate: String?
    var mbrRegDate: String?
    var links: Links?
    var message: String?
    var status: Int?
    var errors: [String]?
    var code: String?

    init(id: String, password: String, email: String) {
        mbrID = id
        mbrPwd = password
        mbrEmail = email
    }
    
    enum CodingKeys: String, CodingKey {
        case mbrID = "mbrId"
        case mbrPwd, mbrName, mbrEmail
        case mbrUUID = "mbrUuid"
        case mbrType, mbrPhoneNum, media, topic, bookmark, mbrPoint, grade, mbrGrade, mbrState, mbrUseYn, mbrUdtDate, mbrRegDate, message, status, errors, code
        case links = "_links"
    }
}

struct Grade: Codable {
    let grdRange: Int
    let grdLevel, grdNickname: String
    let grdUseYn: Bool
    let grdUdtDate: String?
    let grdRegDate: String
}
