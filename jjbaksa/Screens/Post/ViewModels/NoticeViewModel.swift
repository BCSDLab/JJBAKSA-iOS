//
//  NoticeViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/03.
//

import Foundation

class NoticeViewModel: ObservableObject {
    @Published var notice: PostResponse?
    @Published var status: Bool?
    @Published var currentPage: Int = 0
    func getNotice() {
        //let request = PostRequest(boardType: "NOTICE", page: 0, size: 10, sort: "")
        PostRepository.getPost(boardType: "NOTICE", page: currentPage) { result in
            switch(result) {
            case .success(let value):
                self.notice = value
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
            !(notice?.content.isEmpty ?? true) && notice?.content.count ?? 0 < notice?.totalElements ?? 0
        }
    }
    
    func getNewNotice() {
        currentPage += 1
        //let request = PostRequest(boardType: "NOTICE", page: currentPage, size: 10, sort: "")
        PostRepository.getPost(boardType: "NOTICE", page: currentPage) { result in
            switch(result) {
            case .success(let value):
                self.notice?.content.append(contentsOf: value.content)
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
