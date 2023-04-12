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
    @Published var user: User?              // 유저 정보
    @Published var token: Token? = nil      // 토큰
    @Published var isTokenSave: Bool = true
    
    init() {
        loadToken()
    }
    
    // 토큰 받아오기
    func setToken(token: Token) {
        self.token = token
        
            UserDefaults.standard.set(token.accessToken, forKey: "access_token")
            UserDefaults.standard.set(token.refreshToken, forKey: "refresh_token")
        
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
        UserRepository.getUserInfo() { result in
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
        UserRepository.changeNickname(nickname: nickname) { result in
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
        let userRequest: UserRequest = UserRequest(account: account, email: email, password: password, nickname: nickname)
        UserRepository.changeUserInfo(userRequest: userRequest) { result in
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
        self.user = nil
        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.removeObject(forKey: "refresh_token")
    }
    
    func shutDown() {
        print("shut down")
        if isTokenSave == false {
            self.token = nil
            self.user = nil
            UserDefaults.standard.removeObject(forKey: "access_token")
            UserDefaults.standard.removeObject(forKey: "refresh_token")
        }
    }
}


