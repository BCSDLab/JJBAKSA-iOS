//
//  MyPageViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/02/27.
//

import Foundation

class MyPageViewModel: ObservableObject {
    @Published var isEditShow: Bool = false
    @Published var index: Int = 0
    @Published var newNickname: String = "" {
        didSet {
            if newNickname.count > limit {
                newNickname = String(newNickname.prefix(limit))
            }
        }
    }
    
    let limit = 10
    
    func toggleIsEditShow() {
        isEditShow.toggle()
    }
    
    func deleteNewNickname() {
        self.newNickname = ""
    }

}
