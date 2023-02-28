//
//  SettingViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/03/20.
//

import Foundation

class SettingViewModel: ObservableObject {
    // 현재 버전
    let nowVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    
    // 앱스토어 버전
    func latestVersion() -> String? {
        guard
            let bundleIdentifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String,
            let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(bundleIdentifier)"),
            let data = try? Data(contentsOf: url),
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
            let results = json["results"] as? [[String: Any]],
            let appStoreVersion = results[0]["version"] as? String else {
            return nil
        }
        return appStoreVersion
    }
    
    var isNowVersionLatest: Bool {
        if nowVersion == "0.0" { return true } //Test용 코드
        //if nowVersion == latestVersion(){ return true } //TODO: 출시 이후에 코드 적용
        else{ return false }
    }
}
