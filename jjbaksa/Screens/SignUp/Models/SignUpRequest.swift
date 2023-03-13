//
//  SignUpParam.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/03/13.
//

import Foundation


struct SignUpRequest: Codable {
    var account: String
    var password: String
    var email: String
    var nickname: String
    
    enum CodingKeys: String, CodingKey {
        case account, password, email, nickname
    }
}
