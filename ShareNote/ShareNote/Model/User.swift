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
    let mbrID, mbrPwd, mbrName, mbrEmail: String?
    let mbrUUID: String?
    let mbrType: String? = "normal"
    let mbrPhoneNum: String?
    let media, topic, bookmark: [String]?
    let mbrPoint: Int?
    let grade: Grade?
    let mbrGrade: String?
    let mbrState: Int?
    let mbrUseYn: Bool?
    let mbrUdtDate: String?
    let mbrRegDate: String?
    let links: Links?
    let message: String?
    let status: Int?
    let errors: [String]?
    let code: String?

    init(id: String, password: String, phoneNumber: String, email: String) {
        mbrID = id
        mbrPwd = password
        mbrPhoneNum = phoneNumber
        mbrEmail = email
        
        mbrName = nil
        mbrUUID = nil
        media = nil
        topic = nil
        bookmark = nil
        mbrPoint = nil
        grade = nil
        mbrGrade = nil
        mbrState = nil
        mbrUseYn = nil
        mbrUdtDate = nil
        mbrRegDate = nil
        links = nil
        message = nil
        status = nil
        errors = nil
        code = nil
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
