//
//  jjbaksaApp.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/23.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

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
        KakaoSDK.initSDK(appKey: dictionary["KAKAO_ NATIVE_APP_KEY"] as? String ?? "")
    }
    var body: some Scene {
        WindowGroup {
           LogInScreen()
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
