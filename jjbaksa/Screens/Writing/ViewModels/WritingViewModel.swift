//
//  WritingViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/05/08.
//

import Foundation

class WritingViewModel: ObservableObject {
    let storeName: String
    @Published var content: String = ""
    @Published var isShowPhotoLibrary: Bool = false
    @Published var imgArr: [imageArray] = []
    @Published var rate: Int = 0
    
    init(storeName: String) {
        self.storeName = storeName
    }
    
    func setRate(index: Int) {
        rate = index
    }
}
