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
    
    static func signUp(account: String, password: String, email: String, nickname: String, completion: @escaping (Result<User, AFError>) -> Void) {
        AF.request("https://api.stage.jjbaksa.com:443/user", method: .post, parameters: SignUpRequest(account: account, password: password, email: email, nickname: nickname), encoder: .json())
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
