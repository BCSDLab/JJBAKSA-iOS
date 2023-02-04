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
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "14ead7eb667ae2afb2e2ed8c3e38d288")
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
