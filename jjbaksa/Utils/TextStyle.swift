//
//  TextStyle.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/03/20.
//

import SwiftUI

extension View {
    public func size10Regular() -> some View {
        self.font(.custom("SUIT-Regular", size: 10))
    }

    public func size10Medium() -> some View {
        self.font(.custom("SUIT-Medium", size: 10))
    }

    public func size11Regular() -> some View {
        self.font(.custom("SUIT-Regular", size: 11))
    }

    public func size11Medium() -> some View {
        self.font(.custom("SUIT-Medium", size: 11))
    }

    public func size12Regular() -> some View {
        self.font(.custom("SUIT-Regular", size: 12))
    }

    public func size12Medium() -> some View {
        self.font(.custom("SUIT-Medium", size: 12))
    }

    public func size14Regular() -> some View {
        self.font(.custom("SUIT-Regular", size: 14))
    }

    public func size14Medium() -> some View {
        self.font(.custom("SUIT-Medium", size: 14))
    }

    public func size16Regular() -> some View {
        self.font(.custom("SUIT-Regular", size: 16))
    }

    public func size16Medium() -> some View {
        self.font(.custom("SUIT-Medium", size: 16))
    }

    public func size16Bold() -> some View {
        self.font(.custom("SUIT-Bold", size: 16))
    }

    public func size18Regular() -> some View {
        self.font(.custom("SUIT-Regular", size: 18))
    }

    public func size18Medium() -> some View {
        self.font(.custom("SUIT-Medium", size: 18))
    }

    public func size18Bold() -> some View {
        self.font(.custom("SUIT-Bold", size: 18))
    }

    func sizeCustom(_ size: CGFloat, _ weight: fontWeight = .regular) -> some View {
        switch(weight) {
        case .regular :
            return self.font(.custom("SUIT-Regular", size: size))
        case .medium :
            return self.font(.custom("SUIT-Medium", size: size))
        case .bold :
            return self.font(.custom("SUIT-Bold", size: size))
        }
    }
}

enum fontWeight {
    case regular
    case medium
    case bold
}
