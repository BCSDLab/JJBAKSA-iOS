//
//  MyPageViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/02/27.
//

import Foundation

class MyPageViewModel: ObservableObject {
    @Published var isEditShow: Bool = false

    func toggleIsEditShow() {
        isEditShow = !isEditShow
    }
}
