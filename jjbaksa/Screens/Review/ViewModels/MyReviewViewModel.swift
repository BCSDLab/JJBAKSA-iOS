//
//  MyReviewViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/17.
//

import Foundation

class MyReviewViewModel: PaginationProtocol {
    typealias itemType = Review
    @Published var list: Array<itemType>?
    @Published var status: Bool?
    @Published var currentPage: Int = 0
    @Published var totalPage: Int = 0
    @Published var totalElement: Int = 0
    @Published var firstElementID: Int = 0
    
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
        if currentPage == 0 {   // MARK: 현재 페이지가 0. 즉, 최초 실행 시.
            ReviewRepository.getMyReview(page: currentPage) { result in
                switch(result) {
                case .success(let value):
                    self.list = value.content
                    self.currentPage += 1
                    self.totalPage = value.totalPages
                    self.totalElement = value.totalElements
                    self.setFirstElementID()
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
    

    
    func getNextList() {
        ReviewRepository.getMyReview(page: currentPage) { result in
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
    
    func setFirstElementID() {  //MARK: 첫번째 후기의 id를 저장.
        if !list!.isEmpty {
            firstElementID = list![0].id
        }
    }
    
}
