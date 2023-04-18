//
//  ReviewResponse.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/17.
//

import Foundation

struct ReviewResponse: Codable {
    let content: [Review]
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

struct Review: Codable, Hashable {
    let id: Int
    let content: String
    let createdAt: [Int]
    let rate: Int
    let reviewImages: [ReviewImageResponse]?
    let shopReviewResponse: ShopReviewResponse
    let userReviewResponse: UserReviewResponse
}

struct ReviewImageResponse: Codable, Hashable {
    let imageId: Int
    let imageUrl: String
    let originalName: String
    let path: String
}

struct ShopReviewResponse: Codable, Hashable {
    let id: Int
    let categoryName: String
    let placeId: String
    let placeName: String
}

struct UserReviewResponse: Codable, Hashable {
    let id: Int
    let account: String
    let nickname: String
}


  
