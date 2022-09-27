//
//  Token.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/27.
//

import Foundation

// MARK: - Token
struct Token: Codable {
    let accessToken, refreshToken: String
}
