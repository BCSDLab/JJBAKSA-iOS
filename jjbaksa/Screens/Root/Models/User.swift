//
//  User.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/03/13.
//

import Foundation

struct User: Codable {
    var account: String?
    var email: String?
    let id: Int?
    var nickname: String?
    let oauthType: String?
    let profileImage: profileImage?
    let userCountResponse: userCountResponse?
    let userType: String?
    
    enum CodingKeys: String, CodingKey {
        case account, email, id, nickname, oauthType, profileImage, userCountResponse, userType
    }
}

struct profileImage: Codable {
    let id: Int
    let originalName: String
    let path: String
    let url: String
}

struct userCountResponse: Codable {
    let friendCount: Int
    let id: Int
    let reviewCount: Int
}


