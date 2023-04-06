//
//  PostRequest.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/03.
//

import Foundation

struct PostRequest: Codable {
    let boardType: String
    let page: Int
    let size: Int
    let sort: String
}
