//
//  SearchProtocol.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/05/03.
//

import Foundation

protocol SearchProtocol: ObservableObject {
    var searchText: String { get set }
    var trendings: [Trending] { get set }
    var recentSearches: [RecentSearch] { get set }
    var autoCompletes: [String] { get set }
    var isSearched: Bool { get set }

    
    func getTrending()
    func getAutoComplete()
    func setSearchText(text: String)
    func searchShopList()
    func deleteAllRecentSearch()
    func deleteRecentSearch(index: Int)
}
