//
//  UserRepository.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/27.
//

import Foundation
import Alamofire

class UserRepository {
    static let url: String = "https://api.stage.jjbaksa.com:443"
    static let token: String = UserDefaults.standard.object(forKey: "access_token") as? String ?? "" //TODO: 로그인 시 토큰 다시 불러오기
    static let tokenHeader: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
    
    static func logIn(logInRequest: LogInRequest, completion: @escaping (Result<Token, AFError>) -> Void) {
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
        let parameters = QueryString(parameter: ["account"], value: [account])
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
        let parameters = QueryString(parameter: ["nickname"], value: [nickname])
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
        let parameters = QueryString(parameter: ["email"], value: [eMail])
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
        let parameters = QueryString(parameter: ["email", "code"], value: [eMail, code])
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
        let parameters = QueryString(parameter: ["password"], value: [password])
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
