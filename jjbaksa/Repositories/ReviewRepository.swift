//
//  ReviewRepository.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/17.
//

import Foundation
import Alamofire

class ReviewRepository {
    static let url: String = "https://api.stage.jjbaksa.com:443"
    static let token: String = UserDefaults.standard.object(forKey: "access_token") as? String ?? ""
    static let tokenHeader: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
    
    static func getMyReview(page: Int , completion: @escaping (Result<ReviewResponse, AFError>) -> Void) {
        let parameters: Parameters = ["page": page]
        AF.request("\(self.url)/review", method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: tokenHeader)
            .responseDecodable(of: ReviewResponse.self) { response in
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
