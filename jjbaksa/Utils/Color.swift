//
//  Color.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/16.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
    
    static let textMain = Color(hex: "#222222")
    static let textSub = Color(hex: "#FFFFFF")
    static let base = Color(hex: "#C4C4C4")
    static let line = Color(hex: "#EEEEEE")
    static let main = Color(hex: "#FF7F23")
    static let sub = Color(hex: "#F6BF54")
    static let munan = Color(hex: "#666666")
}
