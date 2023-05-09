//
//  WritingSearchViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/05/03.
//

import Foundation

class WritingSearchViewModel: SearchProtocol, PaginationProtocol {
    typealias itemType = Shop
    
    @Published var searchText: String = ""
    @Published var trendings: [Trending] = []
    @Published var recentSearches: [RecentSearch] = []
    @Published var autoCompletes: [String] = []
    @Published var isSearched: Bool = false
    
    @Published var list: Array<itemType>?
    @Published var status: Bool?
    @Published var currentPage: Int = 0
    @Published var totalPage: Int = 0
    @Published var totalElement: Int = 0
    
    var isLoading: Bool {
        get {
            status == nil
        }
    }
    
    var hasMore: Bool {
        get {
            !(list?.isEmpty ?? true) && currentPage < totalPage
        }
    }
    func getTrending() {
        ShopRepository.getTrending() { result in
            switch(result) {
            case .success(let value):
                self.trendings = value.trendings.map { Trending(text: $0, isPressed: false) }
                print(value)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func getAutoComplete() {
        ()
    }
    
    func setSearchText(text: String) {
        self.searchText = text
    }

    
    func searchShopList() {
        /*
        ShopRepository.searchShopList(keyword: searchText) { result in
            switch(result) {
            case .success(let value):
                self.searchedShops = value.content.map { SearchedShop(name: $0.placeName, placeID: $0.placeID, isPressed: false) }
                break
            case .failure(let error):
                print(error)
                break
            }
            
        }*/
    }
    
    func emptyShopList() {
        list = []
    }
    
    func addRecentSearch(placeName: String) {
        recentSearches.append(RecentSearch(text: placeName, isPressed: false))
    }
    
    func deleteAllRecentSearch() {
        recentSearches = []
    }
    
    func deleteRecentSearch(index: Int) {
        recentSearches.remove(at: index)
    }
    
    func getList() {
        currentPage = 0
        ShopRepository.searchShopList(keyword: searchText, page: currentPage) { result in
            switch(result) {
            case .success(let value):
                self.list = value.content
                self.totalPage = value.totalPages
                self.totalElement = value.totalElements
                self.currentPage += 1
                self.status = true
                break
            case .failure(let error):
                print(error)
                self.status = false
                break
            }
        }
    }
    
    func getNextList() {
        ShopRepository.searchShopList(keyword: searchText, page: currentPage) { result in
            switch(result) {
            case .success(let value):
                self.list?.append(contentsOf: value.content)
                self.currentPage += 1
                self.totalPage = value.totalPages
                self.totalElement = value.totalElements
                self.status = true
                break
            case .failure(let error):
                print(error)
                self.status = false
                break
            }
        }
    }
}
