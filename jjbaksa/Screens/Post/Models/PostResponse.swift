//
//  PostResponse.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/03.
//

import Foundation

struct PostResponse: Codable {
    var content: [Post]
    let empty: Bool
    let first: Bool
    let last: Bool
    let number: Int
    let numberOfElements: Int
    let pageable: Pageable
    let size: Int
    let sort: Sort
    let totalElements: Int
    let totalPages: Int
}

struct Post: Codable, Hashable {
    var title: String
    var content: String
    var boardType: String
    var createdAt: String
}

struct Pageable: Codable {
    let offset: Int
    let pageNumber: Int
    let pageSize: Int
    let paged: Bool
    let unpaged: Bool
    let sort: Sort
}


struct Sort: Codable {
    let empty: Bool
    let sorted: Bool
    let unsorted: Bool
}
