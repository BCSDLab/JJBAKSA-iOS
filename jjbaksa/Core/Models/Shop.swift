//
//  Shop.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/05/04.
//

import Foundation

struct Shop: Codable, Hashable {
    let placeID: String
    let placeName: String
    let shopID: Int
    let businessDay: String?
    let categoryName: String?
    let phone: String?
    let address: String?
    let x, y: String
    let dist: Double?
    let score: Double?
    let totalRating: Int?
    let ratingCount: Int?

    enum CodingKeys: String, CodingKey {
        case placeID = "placeId"
        case placeName
        case shopID = "shopId"
        case businessDay, categoryName, phone, address
        case x, y, dist
        case score, totalRating, ratingCount
    }
}


