//
//  RootViewModel.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/23.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

class RootViewModel: ObservableObject {
    @Published var user: User?         // 유저 정보
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
        loadUser()
    }
    
    // 토큰 불러오기
    func loadToken() {
        let accessToken = UserDefaults.standard.string(forKey: "access_token")
        let refreshToken = UserDefaults.standard.string(forKey: "refresh_token")
        
        if(accessToken != nil && refreshToken != nil) {
            self.token = Token(accessToken: accessToken!, refreshToken: refreshToken!)
        }
        loadUser()
    }

    
    // 유저 정보 불러오기
    func loadUser() {
        let header: HTTPHeaders = ["Authorization" : "Bearer \(token?.accessToken ?? "")"]
        UserRepository.getUserInfo(token: header) { result in
            switch(result) {
            case .success(let value):
                self.user = value
                print(value)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    // 닉네임 바꾸기
    func changeNickname(nickname: String) {
        let header: HTTPHeaders = ["Authorization" : "Bearer \(token?.accessToken ?? "")"]
        UserRepository.changeNickname(token: header, nickname: nickname) { result in
            switch(result) {
            case .success(let value):
                self.user?.nickname = value.nickname
                print(value)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func changeUserInfo(account: String?, email: String?, password: String?, nickname: String?) {
        let header: HTTPHeaders = ["Authorization" : "Bearer \(token?.accessToken ?? "")"]
        UserRepository.changeUserInfo(token: header, account: account ?? nil, email: email ?? nil, password: password ?? nil, nickname: nickname ?? nil) { result in
            switch(result) {
            case .success(let value):
                self.user?.account = value.account
                self.user?.email = value.email
                self.user?.nickname = value.nickname
                print(value)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func logOut() {
        self.token = nil
    }
}


