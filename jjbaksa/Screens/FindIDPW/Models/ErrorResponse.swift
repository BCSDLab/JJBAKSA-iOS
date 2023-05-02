//
//  ErrorResponse.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/24.
//

import Foundation

struct ErrorResponse: Codable {
    let className: String
    let errorMessage: String
    let code: Int
    let httpStatus: String
    let errorTrace: String
}

