//
//  UserRepository.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/27.
//

import Foundation
import Alamofire

class UserRepository {
    static func logIn(account: String, password: String, completion: @escaping (Result<Token, AFError>) -> Void) {
        AF.request("https://api.stage.jjbaksa.com:443/user/login", method: .post, parameters: LogInRequest(account: account, password: password), encoder: .json())
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
        AF.request("https://api.stage.jjbaksa.com:443/user/exists?account=\(account)", method: .get)
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
    
    static func getUserInfo(token: HTTPHeaders, completion: @escaping (Result<User, AFError>) -> Void) {
        AF.request("https://api.stage.jjbaksa.com:443/user/me", method: .get, headers: token)
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
    
    //TODO: patch를 param으로 안보내고 url을 직접 지정해도 괜찮은지?
    static func changeNickname(token: HTTPHeaders, nickname: String, completion: @escaping (Result<User, AFError>) -> Void) {
        AF.request("https://api.stage.jjbaksa.com:443/user/nickname?nickname=\(nickname)", method: .patch, headers: token)
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
    static func changeUserInfo(token: HTTPHeaders, account: String?, email: String?, password: String?, nickname: String?, completion: @escaping (Result<User, AFError>) -> Void) {
        AF.request("https://api.stage.jjbaksa.com:443/user/me", method: .patch, parameters: UserRequest(account: account, email: email, password: password, nickname: nickname), encoder: .json(), headers: token)
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
    
}
