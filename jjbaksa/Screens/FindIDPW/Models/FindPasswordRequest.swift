//
//  FindPasswordRequest.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/03/30.
//

import Foundation

struct FindPasswordRequest: Codable {
    let account: String
    let email: String
    let code: String
}
