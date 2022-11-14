//
//  SignUpRepository.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/09.
//

import Foundation
import Alamofire

class ExistRepository {
    static func isOverlap(account: String, completion: @escaping (Result<String, AFError>) -> Void) {
        AF.request("https://api.stage.jjbaksa.com:443/user/exists?account=\(account)", method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseString { response in
                switch(response.result) {
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

