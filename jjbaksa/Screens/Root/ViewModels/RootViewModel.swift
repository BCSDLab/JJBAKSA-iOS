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
    
    init() {
        loadToken()
    }
    
    // 토큰 받아오기
    func setToken(token: Token, isSave: Bool) {
        self.token = token
        if(isSave) {
            UserDefaults.standard.set(token.accessToken, forKey: "access_token")
            UserDefaults.standard.set(token.refreshToken, forKey: "refresh_token")
        }
    }
    
    // 토큰 불러오기
    func loadToken() {
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        let refreshToken = UserDefaults.standard.string(forKey: "refresh_token")
        
        if(accessToken != nil && refreshToken != nil) {
            self.token = Token(accessToken: accessToken!, refreshToken: refreshToken!)
        }
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
