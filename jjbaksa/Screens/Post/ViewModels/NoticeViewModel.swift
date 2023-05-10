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
    @Published var totalElement: Int = 0
    
    var isLoading: Bool {
        get {
            status == nil
        }
    }
    
    var hasMore: Bool {
        get {
            !(list?.isEmpty ?? true) && currentPage < (totalPage)
        }
    }
    
    func getList() {
        currentPage = 0
        PostRepository.getPost(boardType: "NOTICE", page: currentPage) { result in
            switch(result) {
            case .success(let value):
                self.list = value.content
                self.totalPage = value.totalPages
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
        PostRepository.getPost(boardType: "NOTICE", page: currentPage) { result in
            switch(result) {
            case .success(let value):
                self.list?.append(contentsOf: value.content)
                self.currentPage += 1
                self.totalPage = value.totalPages
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
