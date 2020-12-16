//
//  NetworkHelper.swift
//  ShareNote
//
//  Created by sjbyun on 2020/12/15.
//

import Foundation

import Alamofire

class NetworkHelper {
    static let shared = NetworkHelper()
    
    private init() {}
    
    func isExistID(userID: String, completion: @escaping (Bool) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/member/duplicate_id/\(userID)"
        AF.request(url)
            .validate(statusCode: 200..<400)
            .responseJSON { response in
                if let json = try! response.result.get() as? [String : Any] {
                    if let state = json["state"] as? Bool {
                        completion(state)
                    }
                } else {
                    completion(false)
                }
            }
    }
    
    func userLogin(userID: String, password: String) {
        let url = "http://52.79.246.196:8083/api/rest/member/auth?"
        let params: Parameters = ["mbrId" : userID,
                                  "mbrPwd" : password]
        AF.request(url, method: .get, parameters: params)
            .validate(statusCode: 200..<400)
            .responseJSON { response in
                print(response)
            }
    }
    
    func snsLogin() {
        
    }
    
    func register(user: MemberList, completion: @escaping (Bool) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/member/join"        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<400)
            .response { response in
                if let json = try! response.result.get() as? [String : Any] {
                    if let state = json["state"] as? Bool {
                        completion(state)
                    }
                } else {
                    completion(false)
                }
            }
    }
    
    func getAllMember(completion: @escaping ([MemberList]) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/member"
        let header = HTTPHeader(name: "Authorization",
                                value: "Bearer eyJhbGciOiJIUzUxMiJ9.eyJleHAiOjE2MDk5Mjk0MTgsImlhdCI6MTYwNzMzNzQxOCwianRpIjoidGVzdGVyMSJ9.bww7F2l4BvwcqOYBGQpb3KgJWi9kr2KbVTavuySJFSRbxEtXRMpP5JldrGsMNrpX1k3vEXDhxaqahF99ctp60w")
        
        AF.request(url, headers: [header])
            .validate(statusCode: 200..<400)
            .responseDecodable(of: Welcome.self) { response in
                if let json = try! response.result.get() as? Welcome {
                    completion(json.embedded.memberList)
                }
            }
    }
    
    func deleteUser(completion: @escaping ([Bool]) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/member"
        let header = HTTPHeader(name: "Authorization", value: "Bearer eyJhbGciOiJIUzUxMiJ9.eyJleHAiOjE2MTA2Mzg2MjEsImlhdCI6MTYwODA0NjYyMSwianRpIjoiZGF2ZSJ9.MJ6VShEvREjDf_IJ2D7fuExdaFvfiMLEqDQA6pLW1OiAHRJZFqloowiFqHQPQdJA7Zjtwqe5gNYkRXggHrdF-w")
        AF.request(url, method: .delete, headers: [header])
            .validate(statusCode: 200..<400)
            .response { response in
                print(response)
            }
    }
}
