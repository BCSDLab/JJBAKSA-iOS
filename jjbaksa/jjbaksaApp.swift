//
//  jjbaksaApp.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import KakaoSDKCommon
import KakaoSDKAuth
import NaverThirdPartyLogin

@main
struct jjbaksaApp: App {
    init() {
        // 키 정보 불러오기
        guard let keyInfo = Bundle.main.url(forResource: "KeyInfo", withExtension: "plist") else {
            return
        }
        
        guard let dictionary = NSDictionary(contentsOf: keyInfo) else {
            return
        }
        
        // Google SDK 초기화 //TODO: GIDClientID를 무조건 Info.plist에 넣어야하는 것인지
        //GIDConfiguration.init(clientID: dictionary["GOOGLE_CLIENT_ID"] as? String ?? "")

        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: dictionary["KAKAO_NATIVE_APP_KEY"] as? String ?? "")
        
        // Naver SDK 초기화
        NaverThirdPartyLoginConnection.getSharedInstance().resetToken()
        NaverThirdPartyLoginConnection.getSharedInstance().requestDeleteToken()
        // 네이버 앱으로 로그인 허용
        NaverThirdPartyLoginConnection.getSharedInstance()?.isNaverAppOauthEnable = true
        // 브라우저 로그인 허용
        NaverThirdPartyLoginConnection.getSharedInstance()?.isInAppOauthEnable = true
 
        // 네이버 로그인 세로모드 고정
        NaverThirdPartyLoginConnection.getSharedInstance().setOnlyPortraitSupportInIphone(true)
        
        NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme = dictionary["NAVER_SERVICE_APP_URL_SCHEME"] as? String ?? ""
        NaverThirdPartyLoginConnection.getSharedInstance().consumerKey = dictionary["NAVER_CONSUMER_KEY"] as? String ?? ""
        NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret = dictionary["NAVER_CONSUMER_SECRET"] as? String ?? ""
        NaverThirdPartyLoginConnection.getSharedInstance().appName = dictionary["NAVER_SERVICE_APP_NAME"] as? String ?? ""
        
    }
    //TODO: 구글 로그인도 마찬가지로 해야하는지?
    func isGoogleLoginUrl(_ url:URL) -> Bool {
        if url.absoluteString.hasPrefix("") {
            return true
        }
        return false
    }
    
    
    func isNaverLoginUrl(_ url:URL) -> Bool {
        if url.absoluteString.hasPrefix("jjbaksanaverios://") {
            return true
        }
        return false
    }
    
    var body: some Scene {
        WindowGroup {
            RootScreen()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                    //if (isGoogleLoginUrl(url)) {
                    //    GIDSignIn.sharedInstance.handle(url)
                    //}
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    } else if(isNaverLoginUrl(url)) {
                        NaverThirdPartyLoginConnection
                                                    .getSharedInstance()
                                                    .receiveAccessToken(url)
                    }
                }
        }
    }
}
