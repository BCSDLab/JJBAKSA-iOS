//
//  TextStyle.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/03/20.
//

import SwiftUI

extension View {
    public func size10Regular() -> some View {
        self.font(.system(size: 10, weight: .regular))
    }

    public func size10Medium() -> some View {
        self.font(.system(size: 10, weight: .medium))
    }

    public func size11Regular() -> some View {
        self.font(.system(size: 11, weight: .regular))
    }

    public func size11Medium() -> some View {
        self.font(.system(size: 11, weight: .medium))
    }

    public func size12Regular() -> some View {
        self.font(.system(size: 12, weight: .regular))
    }

    public func size12Medium() -> some View {
        self.font(.system(size: 12, weight: .medium))
    }

    public func size14Regular() -> some View {
        self.font(.system(size: 14, weight: .regular))
    }

    public func size14Medium() -> some View {
        self.font(.system(size: 14, weight: .medium))
    }

    public func size16Regular() -> some View {
        self.font(.system(size: 16, weight: .regular))
    }

    public func size16Medium() -> some View {
        self.font(.system(size: 16, weight: .medium))
    }

    public func size16Bold() -> some View {
        self.font(.system(size: 16, weight: .bold))
    }

    public func size18Regular() -> some View {
        self.font(.system(size: 18, weight: .regular))
    }

    public func size18Medium() -> some View {
        self.font(.system(size: 18, weight: .medium))
    }

    public func size18Bold() -> some View {
        self.font(.system(size: 18, weight: .bold))
    }

    public func sizeCustom(_ size: CGFloat, _ weight: Font.Weight = .regular) -> some View {
        self.font(.system(size: size, weight: weight))
    }
}
