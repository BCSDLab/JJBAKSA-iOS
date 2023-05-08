//
//  ShopRepository.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/05/03.
//

import Foundation
import Alamofire

class ShopRepository {
    static let url: String = "https://api.stage.jjbaksa.com:443"
    static let token: String = UserDefaults.standard.object(forKey: "access_token") as? String ?? ""
    static let tokenHeader: HTTPHeaders = ["Authorization" : "Bearer \(token)"]
    
    static func getTrending(completion: @escaping (Result<TrendingResponse, AFError>) -> Void) {
        AF.request("\(self.url)/trending", method: .get, headers: tokenHeader)
            .responseDecodable(of: TrendingResponse.self) { response in
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
    
    static func searchShopList(keyword: String, page: Int, x: Double = 127.96723316031301, y: Double = 35.70068507556328, completion: @escaping (Result<ShopList, AFError>) -> Void) {
        let parameters: Parameters = ["keyword": keyword, "page": page, "x": x, "y": y]
        AF.request("\(self.url)/shops", method: .post, parameters: parameters, encoding: URLEncoding.queryString, headers: tokenHeader)
            .responseDecodable(of: ShopList.self) { response in
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
