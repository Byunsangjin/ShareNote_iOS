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
    
    // MARK: User
    func isExistID(userID: String, completion: @escaping (Bool) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/member/duplicate_id/\(userID)"
        AF.request(url)
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
            .responseJSON { response in
                print(response)
            }
    }
    
    func snsLogin() {
        
    }
    
    func register(user: Member, completion: @escaping (Bool) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/member/join"        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .response { response in
                print(response)
            }
    }
    
    func getAllMember(completion: @escaping ([Member]) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/member"
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .validate(statusCode: 200..<400)
            .responseDecodable(of: JsonData.self) { response in
                if let json = try? response.result.get() as JsonData {
                    completion(json.embedded.memberList!)
                }
            }
    }
    
    func getMember(userID: String, completion: @escaping ([Bool]) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/member"
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .responseDecodable(of: JsonData.self) { response in
                print(response)
            }
    }
    
    func modifiedMember(user: Member, completion: @escaping (Bool) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/member"
        let header: HTTPHeader = HTTPHeader(name: "Authorization",
                                            value: TEST_AUTHORIZATION)
        let params: Parameters = ["mbrName" : "dave",
                                  "mbrPwd" : "dave",
                                  "mbrEmail" : "aaa@gmail.com",
                                  "mbrPhoneNum" : "01086973025"]
                                                
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: [header])
            .response { response in
                print("response + \(response)")
            }
    }
    
    func deleteUser(completion: @escaping ([Bool]) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/member"
        let header = HTTPHeader(name: "Authorization", value: TEST_AUTHORIZATION)
        AF.request(url, method: .delete, headers: [header])
            .response { response in
                print(response)
            }
    }
    
    // MARK: Category
    func getCategory(completion: @escaping ([Bool]) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/member/category"
        let header = HTTPHeader(name: "Authorization", value: TEST_AUTHORIZATION)
        AF.request(url, headers: [header])
            .response { response in
                if let json = try! response.result.get() {
                    print(json)
                }
            }
    }
    
    func addCategory(completion: @escaping ([Bool]) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/member/category"
        let header = HTTPHeader(name: "Authorization", value: TEST_AUTHORIZATION)
        
        // 추가 시 "mbrCategory": "1,2,3,4,5", 삭제 시 ""
        let params: Parameters = ["mbrCategory" : "1,2,7,10"];
        
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: [header])
            .response { response in
                print("response + \(response)")
            }
    }
    
    func getAllCategory(completion: @escaping ([Category]) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/category"
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .responseDecodable(of: JsonData.self) { response in
                if let json = try? response.result.get() as JsonData {
                    print(json.embedded.categoryList!)
                }
            }
    }
    
    func getAllDetailCategory(completion: @escaping ([CategoryDetailList]) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/category/detail"
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .responseDecodable(of: JsonData.self) { response in
                if let json = try? response.result.get() as JsonData {
                    print(json.embedded.categoryDetailList?.first)
                }
            }
    }
    
    func getDetailCategory(completion: @escaping ([CategoryDetailList]) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/category/detail/\(3)"
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .responseDecodable(of: JsonData.self) { response in
                if let json = try? response.result.get() as JsonData {
                    print(json.embedded.categoryDetailList?.first)
                }
            }
    }
    
    func getSearchCategory(keyword: String, completion: @escaping ([CategoryDetailList]) -> Void) {
        guard let url = "http://52.79.246.196:8083/api/rest/category/진단키트".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .responseDecodable(of: JsonData.self) { response in
                if let json = try? response.result.get() as JsonData {
                    print(json.embedded.categoryDTOList)
                }
            }
    }
    
    func getTop10Category(completion: @escaping ([Category]) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/category/top10"
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .responseDecodable(of: JsonData.self) { response in
                if let json = try? response.result.get() as JsonData {
                    print(json.embedded.categoryList)
                }
            }
    }
    
    // MARK: Tag
    func getTag(completion: @escaping ([Tag]) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/tag"
        let header = HTTPHeader(name: "Authorization",
                                value: TEST_AUTHORIZATION)
        
        AF.request(url, headers: [header])
            .responseDecodable(of: JsonData.self) { response in
                if let json = try? response.result.get() as JsonData {
                    print(json)
                }
            }
    }
    
    func addTag(tag: Tag, completion: @escaping ([Bool]) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/tag"
        
        let authorization = TEST_AUTHORIZATION
        let header = HTTPHeader(name: "Authorization", value: authorization)
        
        AF.request(url, method: .post, parameters: tag, encoder: JSONParameterEncoder.default, headers: [header])
            .responseJSON { response in
                print(response)
            }
    }
    
    func deleteTag(completion: @escaping ([Bool]) -> Void) {
        let url = "http://52.79.246.196:8083/api/rest/tag/19"
        let header = HTTPHeader(name: "Authorization", value: TEST_AUTHORIZATION)
        AF.request(url, method: .delete, headers: [header])
            .response { response in
                print(response)
            }
    }
}
