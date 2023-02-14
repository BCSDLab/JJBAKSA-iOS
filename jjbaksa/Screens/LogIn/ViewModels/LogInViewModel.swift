//
//  LogInViewModel.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/27.
//

import Foundation
import NaverThirdPartyLogin
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

class LogInViewModel: NSObject, ObservableObject {
    @Published var account: String = ""
    @Published var password: String = ""
    @Published var isAutoLogIn: Bool = true
    @Published var isLogInFailed: Bool = false
    @Published var token: Token? = nil
    
    //account와 password가 비어있는지 확인.
    var isInfoNotEmpty: Bool {
        !account.isEmpty && !password.isEmpty
    }
    
    func logIn() {
        if(isInfoNotEmpty) {
            UserRepository.logIn(account: account, password: password) { result in
                switch(result) {
                case .success(let value):
                    self.token = value
                    self.isLogInFailed = false
                    print(value)
                    break
                case .failure(let error):
                    self.isLogInFailed = true
                    print(error)
                    break
                }
            }
        } else {
            // TODO: 모두 입력되지 않을 경우 에러 표시
        }
    }
    
    func logInByKakao() {
         if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                print(oauthToken)
                print(error)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                print(oauthToken)
                print(error)
            }
        }
    }
    
    func logInByNaver() {
        NaverThirdPartyLoginConnection.getSharedInstance().delegate = self
        NaverThirdPartyLoginConnection
            .getSharedInstance()
            .requestThirdPartyLogin()
    }
    
    func checkNaver(naverAccessToken: String) {
        print("Naver Access Token : \(naverAccessToken)")
    }
}

extension LogInViewModel : NaverThirdPartyLoginConnectionDelegate {
    // 토큰 발급 성공시
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        guard let accessToken = NaverThirdPartyLoginConnection.getSharedInstance().accessToken else { return }
        checkNaver(naverAccessToken: accessToken)
    }
    
    // 토큰 갱신시
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {}
    
    // 로그아웃(토큰 삭제)시
    func oauth20ConnectionDidFinishDeleteToken() {}
    
    // Error 발생
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error: \(error)")
    }
}
