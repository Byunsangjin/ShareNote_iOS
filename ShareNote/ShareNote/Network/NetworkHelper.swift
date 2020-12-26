//
//  NetworkHelper.swift
//  ShareNote
//
//  Created by sjbyun on 2020/12/15.
//

import Foundation
import Alamofire
import SwiftyBeaver

class NetworkHelper {
    static let shared = NetworkHelper()
    
    private init() {}
    
    // MARK: User
    func isExistID(userID: String, completion: ((Bool) -> Void)?) {
        let url = "http://52.79.246.196:8083/api/rest/member/duplicate_id/\(userID)"
        AF.request(url)
            .responseJSON { response in
                SwiftyBeaver.verbose(response)
                if let json = try! response.result.get() as? [String : Any] {
                    if let state = json["state"] as? Bool {
                        completion?(state)
                    }
                } else {
                    completion?(false)
                }
            }
    }
    
    func userLogin(userID: String, password: String) {
        let url = "http://52.79.246.196:8083/api/rest/member/auth?"
        let params: Parameters = ["mbrId" : userID,
                                  "mbrPwd" : password]
        AF.request(url, method: .get, parameters: params)
            .responseJSON { response in
                SwiftyBeaver.verbose(response)
            }
    }
    
    func snsLogin() {
        
    }
    
    func register(user: Member, completion: ((Bool) -> Void)?) {
        let url = "http://52.79.246.196:8083/api/rest/member/join"        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .responseJSON { response in
                SwiftyBeaver.verbose(response)
            }
    }
    
    func getAllMember(completion: (([Member]) -> Void)?) {
        let url = "http://52.79.246.196:8083/api/rest/member"
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .validate(statusCode: 200..<400)
            .responseDecodable(of: JsonData.self) { response in
                if let json = try? response.result.get() as JsonData {
                    completion?(json.embedded.member!)
                }
            }
    }
    
    func getMember(userID: String, completion: ((Bool) -> Void)?) {
        let url = "http://52.79.246.196:8083/api/rest/member/\(userID)"
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .responseJSON { response in
                SwiftyBeaver.verbose(response)
                if let status = response.response?.statusCode {
                    SwiftyBeaver.verbose(status)
                }
                
                
                if let data = response.data, let json = try? JSONDecoder().decode(Member.self, from: data) {
                    SwiftyBeaver.verbose(json)
                } else {
                    SwiftyBeaver.verbose("Fail")
                }
            }
    }
    
    func modifiedMember(user: Member, completion: ((Bool) -> Void)?) {
        let url = "http://52.79.246.196:8083/api/rest/member"
        let header: HTTPHeader = HTTPHeader(name: "Authorization",
                                            value: TEST_AUTHORIZATION)
        
        AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default, headers: [header])
            .responseJSON { response in
                SwiftyBeaver.verbose("response + \(response)")
            }
    }
    
    func deleteUser(completion: ((Bool) -> Void)?) {
        let url = "http://52.79.246.196:8083/api/rest/member"
        let header = HTTPHeader(name: "Authorization", value: TEST_AUTHORIZATION)
        AF.request(url, method: .delete, headers: [header])
            .response { response in
                SwiftyBeaver.verbose(response.response?.statusCode)
            }
    }
    
    // MARK: Category
    func getCategory(completion: ((Bool) -> Void)?) {
        let url = "http://52.79.246.196:8083/api/rest/member/category"
        let header = HTTPHeader(name: "Authorization", value: TEST_AUTHORIZATION)
        AF.request(url, headers: [header])
            .responseJSON { response in
                SwiftyBeaver.verbose(response)
                
                if let data = response.data, let json = try? JSONDecoder().decode(JsonData.self, from: data) {
                    SwiftyBeaver.verbose(json)
                } else {
                    SwiftyBeaver.verbose("Fail")
                }
            }
    }
    
    func addCategory(params: Dictionary<String, String>, completion: ((Bool) -> Void)?) {
        let url = "http://52.79.246.196:8083/api/rest/member/category"
        let header = HTTPHeader(name: "Authorization", value: TEST_AUTHORIZATION)
        
        // 추가 시 "mbrCategory": "1,2,3,4,5", 삭제 시 ""
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: [header])
            .responseJSON { response in
                SwiftyBeaver.verbose("response + \(response)")
            }
    }
    
    func getAllCategory(completion: (([Category]) -> Void)?) {
        let url = "http://52.79.246.196:8083/api/rest/category"
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .responseDecodable(of: JsonData.self) { response in
                if let json = try? response.result.get() as JsonData {
                    SwiftyBeaver.verbose(json.embedded.category!)
                }
            }
    }
    
    func getAllDetailCategory(completion: (([CategoryDetail]) -> Void)?) {
        let url = "http://52.79.246.196:8083/api/rest/category/detail"
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .responseDecodable(of: JsonData.self) { response in
                if let json = try? response.result.get() as JsonData {
                    SwiftyBeaver.verbose(json.embedded.categoryDetail?.first)
                }
            }
    }
    
    func getDetailCategory(categoryNumber: Int, completion: (([CategoryDetail]) -> Void)?) {
        let url = "http://52.79.246.196:8083/api/rest/category/detail/\(categoryNumber)"
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .responseJSON { response in
                SwiftyBeaver.verbose(response)
                
                if let data = response.data, let json = try? JSONDecoder().decode(JsonData.self, from: data) {
                    SwiftyBeaver.verbose(json)
                } else {
                    SwiftyBeaver.verbose("Fail")
                }
            }
    }
    
    func getSearchCategory(keyword: String, completion: (([CategoryDetail]) -> Void)?) {
        guard let url = "http://52.79.246.196:8083/api/rest/category/\(keyword)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .responseJSON { response in
                SwiftyBeaver.verbose(response)
                
                if let data = response.data, let json = try? JSONDecoder().decode(JsonData.self, from: data) {
                    SwiftyBeaver.verbose(json)
                } else {
                    SwiftyBeaver.verbose("Fail")
                }
            }
    }
    
    func getTop10Category(completion: (([Category]) -> Void)?) {
        let url = "http://52.79.246.196:8083/api/rest/category/top10"
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .responseDecodable(of: JsonData.self) { response in
                if let json = try? response.result.get() as JsonData {
                    SwiftyBeaver.verbose(json.embedded.category)
                }
            }
    }
    
    // MARK: Tag
    func getTag(completion: (([Tag]) -> Void)?) {
        let url = "http://52.79.246.196:8083/api/rest/tag"
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .responseDecodable(of: JsonData.self) { response in
                if let json = try? response.result.get() as JsonData {
                    SwiftyBeaver.verbose(json)
                }
            }
    }
    
    func addTag(tag: Tag, completion: ((Bool) -> Void)?) {
        let url = "http://52.79.246.196:8083/api/rest/tag"
        
        let authorization = TEST_AUTHORIZATION
        let header = HTTPHeader(name: "Authorization", value: authorization)
        
        AF.request(url, method: .post, parameters: tag, encoder: JSONParameterEncoder.default, headers: [header])
            .responseJSON { response in
                SwiftyBeaver.verbose(response)
            }
    }
    
    func deleteTag(completion: ((Bool) -> Void)?) {
        let url = "http://52.79.246.196:8083/api/rest/tag/19"
        let header = HTTPHeader(name: "Authorization", value: TEST_AUTHORIZATION)
        AF.request(url, method: .delete, headers: [header])
            .response { response in
                SwiftyBeaver.verbose(response)
            }
    }
}
