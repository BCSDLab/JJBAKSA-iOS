//
//  NoticeViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/03.
//

import Foundation

class NoticeViewModel: PaginationProtocol {
    typealias itemType = Post
    @Published var list: Array<itemType>?
    @Published var status: Bool?
    @Published var currentPage: Int = 0
    @Published var totalPage: Int = 0
    
    func getList() {
        //let request = PostRequest(boardType: "NOTICE", page: 0, size: 10, sort: "")
        PostRepository.getPost(boardType: "NOTICE", page: currentPage) { result in
            switch(result) {
            case .success(let value):
                self.list = value.content
                self.currentPage = value.pageable.pageNumber
                self.totalPage = value.totalPages
                self.status = true
                print(value)
                break
            case .failure(let error):
                print(error)
                self.status = false
                break
            }
        }
    }
    
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
    
    func getNextList() {
        //let request = PostRequest(boardType: "NOTICE", page: currentPage, size: 10, sort: "")
        PostRepository.getPost(boardType: "NOTICE", page: currentPage) { result in
            switch(result) {
            case .success(let value):
                self.list?.append(contentsOf: value.content)
                self.currentPage = value.pageable.pageNumber
                self.totalPage = value.totalElements
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
