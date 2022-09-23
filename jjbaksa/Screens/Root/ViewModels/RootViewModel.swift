//
//  RootViewModel.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/23.
//

import Foundation
import SwiftUI
import Combine

class RootViewModel: ObservableObject {
    @Published var user: User = User()          // 유저 정보
    @Published var isLoggedIn: Bool = false     // 로그인 여부
    @Published var token: String = ""           // 토큰
    
    // 토큰 불러오기
    func loadToken() {
        
    }
    
    // 유저 정보 불러오기
    func loadUser() {
        
    }
}

struct User {
    
}
