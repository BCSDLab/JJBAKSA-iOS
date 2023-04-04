//
//  ApiFactory.swift
//  jjbaksa
//
//  Created by 정태훈 on 2023/04/04.
//
//

import Foundation
import Alamofire

class ApiFactory {
    static let host: String = "https://api.stage.jjbaksa.com:443/"

    static func getApi<T: Encodable>(type: HTTPMethod, url: String, parameters: T) -> DataRequest {

        var header: HTTPHeaders = []

        let token: String? = UserDefaults.standard.string(forKey: "access_token")

        if(token != nil) {
            header.add(name: "Authorization", value: "Bearer \(token)")
        }

        return AF.request("\(host)\(url)", method: type, parameters: parameters, encoder: JSONParameterEncoder.default, headers: header)
    }

}
