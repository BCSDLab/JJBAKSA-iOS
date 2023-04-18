//
//  Pagination.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/17.
//

import Foundation

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
