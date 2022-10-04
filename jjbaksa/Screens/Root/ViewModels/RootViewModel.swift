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
    @Published var token: Token? = nil           // 토큰
    
    // 토큰 불러오기
    func loadToken(token: Token) {
        self.token = token
    }
    
    // 유저 정보 불러오기
    func loadUser() {
        
    }
    
    func logOut() {
        self.token = nil
    }
}

struct User {
    
}
