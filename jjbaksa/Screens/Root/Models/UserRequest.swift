//
//  UserRequest.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/03/20.
//

import Foundation

struct UserRequest: Codable {
    var account: String?
    var email: String?
    var password: String?
    var nickname: String?
    
    enum CodingKeys: String, CodingKey {
        case account, email, password, nickname
    }
}
