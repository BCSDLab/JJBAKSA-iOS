//
//  PaginationProtocol.swift
//  jjbaksa
//
//  Created by 정태훈 on 2023/04/11.
//

import Foundation

protocol PaginationProtocol: ObservableObject {
    associatedtype itemType: Codable, Hashable
    var list: Array<itemType>? { get set }
    var status: Bool? { get set }
    var currentPage: Int { get set }
    var totalPage: Int { get set }
    
    var isLoading: Bool {get}
    var hasMore: Bool {get}
    
    func getList()
    func getNextList()
}
