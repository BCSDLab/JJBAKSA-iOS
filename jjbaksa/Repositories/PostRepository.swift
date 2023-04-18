//
//  PostRepository.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/03.
//

import Foundation
import Alamofire

class PostRepository {
    static let url: String = "https://api.stage.jjbaksa.com:443"
    static let token: String = UserDefaults.standard.object(forKey: "access_token") as? String ?? "" //TODO: 로그인 시 토큰 다시 불러오기
    static let tokenHeader: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
    
    static func getPost(boardType: String, page: Int , completion: @escaping (Result<PostResponse, AFError>) -> Void) {
        let parameters: Parameters = ["boardType": boardType, "page": page]
        AF.request("\(self.url)/post", method: .get, parameters: parameters, encoding: URLEncoding.queryString)
            .responseDecodable(of: PostResponse.self) { response in
                switch (response.result) {
                case .success(let value):
                    completion(.success(value))
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            }
    }
/*
    static func isOverlap(account: String, completion: @escaping (Result<String, AFError>) -> Void) {
        let parameters: Parameters = ["account": account]
        AF.request("\(self.url)/user/exists", method: .get, parameters: parameters, encoding: URLEncoding.queryString)
            .responseString { response in
                switch (response.result) {
                case .success(let result):
                    completion(.success(result))
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            }
    }
    
    static func getUserInfo(completion: @escaping (Result<User, AFError>) -> Void) {
        AF.request("\(self.url)/user/me", method: .get, headers: tokenHeader)
            .responseDecodable(of: User.self) { response in
                switch (response.result) {
                case .success(let result):
                    completion(.success(result))
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            }
    }
    
    static func changeNickname(nickname: String, completion: @escaping (Result<User, AFError>) -> Void) {
        let parameters: Parameters = ["nickname": nickname]
        AF.request("\(self.url)/user/nickname", method: .patch, parameters: parameters, encoding: URLEncoding.queryString, headers: tokenHeader)
            .responseDecodable(of: User.self) { response in
                switch (response.result) {
                case .success(let result):
                    completion(.success(result))
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            }
    }
    
    //TODO: account를 바꾸는 api가 없는듯..?
    static func changeUserInfo(userRequest: UserRequest, completion: @escaping (Result<User, AFError>) -> Void) {
        AF.request("\(self.url)/user/me", method: .patch, parameters: userRequest, encoder: .json(), headers: tokenHeader)
            .responseDecodable(of: User.self) { response in
                switch (response.result) {
                case .success(let result):
                    completion(.success(result))
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
                }
            }
    }
    
    static func sendCertCode(eMail: String, completion: @escaping (Result<String, AFError>) -> Void) {
        let parameters: Parameters = ["email": eMail]
        AF.request("\(self.url)/user/email", method: .post, parameters: parameters, encoding: URLEncoding.queryString)
                .responseString { response in
                    switch (response.result) {
                    case .success(let value):
                        completion(.success(value))
                        break
                    case .failure(let error):
                        completion(.failure(error))
                        break
                    }
                }
    }
    
    static func findAccount(eMail: String, code: String, completion: @escaping (Result<User, AFError>) -> Void) {
        let parameters: Parameters = ["email": eMail, "code": code]
        AF.request("\(self.url)/user/account", method: .get, parameters: parameters, encoding: URLEncoding.queryString)
                .responseDecodable(of: User.self) { response in
                    switch (response.result) {
                    case .success(let value):
                        completion(.success(value))
                        break
                    case .failure(let error):
                        completion(.failure(error))
                        break
                    }
                }
    }
    
    static func findPassword(request: FindPasswordRequest, completion: @escaping (Result<String, AFError>) -> Void) {
        AF.request("\(self.url)/user/password", method: .post, parameters: request, encoder: .json())
                .responseString() { response in
                    switch (response.result) {
                    case .success(let value):
                        completion(.success(value))
                        break
                    case .failure(let error):
                        completion(.failure(error))
                        break
                    }
                }
    }
    
    static func changePassword(password: String, token: String, completion: @escaping (Result<User, AFError>) -> Void) {
        let parameters: Parameters = ["passwrod": password]
        let header: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
        AF.request("\(self.url)/user/password", method: .patch, parameters: parameters, encoding: URLEncoding.queryString, headers: header)
                .responseDecodable(of: User.self) { response in
                    switch (response.result) {
                    case .success(let value):
                        completion(.success(value))
                        break
                    case .failure(let error):
                        completion(.failure(error))
                        break
                    }
                }
    }
 */
}
