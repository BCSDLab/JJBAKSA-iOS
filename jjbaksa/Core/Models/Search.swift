//
//  Search.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/05/03.
//

import Foundation

struct TrendingResponse: Codable {
    let trendings: [String]
}


struct ShopList: Codable {
    let content: [Shop]
    let empty, first, last: Bool
    let number, numberOfElements: Int
    let pageable: Pageable
    let size: Int
    let sort: Sort
    let totalElements, totalPages: Int
}


struct Trending {
    let text: String
    var isPressed: Bool
}

struct RecentSearch {
    let text: String
    var isPressed: Bool
}

struct SearchedShop {
    let name: String
    let placeID: String
    var isPressed: Bool
}
