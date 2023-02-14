//
//  jjbaksaApp.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/23.
//

import SwiftUI
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
        
        // NaverThirdPartyConstantsForApp.h에 선언한 상수 등록
        NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme = kServiceAppUrlScheme
        NaverThirdPartyLoginConnection.getSharedInstance().consumerKey = kConsumerKey
        NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret = kConsumerSecret
        NaverThirdPartyLoginConnection.getSharedInstance().appName = kServiceAppName
        
    }
    var body: some Scene {
        WindowGroup {
           LogInScreen()
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                    //NaverThirdPartyLoginConnection.getSharedInstance()?.receiveAccessToken(url)
                }
        }
    }
}
