//
//  UserRepository.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/27.
//

import Foundation
import Alamofire

class UserRepository {
    func logIn(logInRequest: LogInRequest, completion: @escaping (Result<Token, AFError>) -> Void) {
        ApiFactory.getApi(type: .post, url: "user/login", parameters: logInRequest)
                .responseDecodable(of: Token.self) { response in
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

    static func isOverlap(account: String, completion: @escaping (Result<String, AFError>) -> Void) {
        let parameters = QueryString(query: ["account" : account])
        ApiFactory.getApi(type: .get, url: "user/exists", parameters: parameters)
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
        ApiFactory.getApi(type: .get, url: "user/me")
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
        let parameters = QueryString(query: ["nickname" : nickname])
        ApiFactory.getApi(type: .patch, url: "user/nickname", parameters: parameters)
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
        ApiFactory.getApi(type: .patch, url: "user/me", parameters: userRequest)
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
        let parameters = QueryString(query: ["email" : eMail])
        ApiFactory.getApi(type: .post, url: "user/email", parameters: parameters)
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
        let parameters = QueryString(query: ["email" : eMail, "code" : code])
        ApiFactory.getApi(type: .get, url: "user/account", parameters: parameters)
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
        ApiFactory.getApi(type: .post, url: "user/password", parameters: request)
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
    
    static func changePassword(password: String, completion: @escaping (Result<User, AFError>) -> Void) {
        let parameters = QueryString(query: ["password" : password])
        ApiFactory.getApi(type: .patch, url: "user/password", parameters: parameters)
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
}
