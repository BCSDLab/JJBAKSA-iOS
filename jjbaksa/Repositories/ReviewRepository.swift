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
    
    static func postReview(content: String, rate: Int, reviewImages: [ImageAsset], shopID: Int, completion: @escaping (Result<Review, AFError>) -> Void) {
        let header: HTTPHeaders = [
            "Content-Type" : "multipart/form-data",
            "Authorization" : "Bearer \(token)"
        ]
        var images: [String] = []
        
        for imageAsset in reviewImages {
            if let imageString = imageAsset.thumbnail?.toPngString() {
                images.append(imageString)
            }
        }
        //parameter
        let parameters: [String : Any] = [
            "content": content,
            "shopId": shopID,
            "rate": rate
            //"reviewImages": images //TODO: 이미지 API 구현 완료 시 구현.
        ]
        
        AF.upload(multipartFormData: { MultipartFormData in
            //body 추가
            for (key, value) in parameters {
                MultipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
        }, to: "\(self.url)/review", method: .post, headers: header)
        .validate()
        .responseDecodable(of: Review.self) { response in
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
