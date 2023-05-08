//
//  CustomTextField.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/05/03.
//

import SwiftUI

extension TextField {
    func customStyle(size: CGFloat, paddingLeading: Int) -> some View {
        self
            .sizeCustom(size, .regular)
    }
}

struct CustomTextField: View {
    private let titleKey: LocalizedStringKey
    private let fontSize: CGFloat
    private let fontWeight: fontWeight
    private let fontColor: Color?
    private let textPadding: CGFloat
    private let width: CGFloat
    private let height: CGFloat
    private let backgroundColor: Color
    private let shadow: Bool
    
    @Binding private var text: String
    
    init(_ titleKey: LocalizedStringKey, fontSize: CGFloat, fontWeight: fontWeight = .regular, fontColor: Color? = nil, textPadding: CGFloat, width: CGFloat, height: CGFloat, backgroundColor: Color, shadow: Bool = false, text: Binding<String>) {
        self.titleKey = titleKey
        self.fontColor = fontColor
        self.fontWeight = fontWeight
        self.fontSize = fontSize
        self.textPadding = textPadding
        self.width = width
        self.height = height
        self.backgroundColor = backgroundColor
        self.shadow = shadow
        self._text = text
    }
    
    var body: some View {
        TextField("", text: $text)
            .padding(.leading, textPadding)
            .frame(width: width, height: height)
            .background(
                ZStack {
                    Capsule()
                        .fill(backgroundColor)
                        .shadow(color: .textMain.opacity(shadow ? 0.1 : 0), radius: 12, x: 2, y: 3)
                        .frame(width: width, height: height)
                    HStack(spacing: 0) {
                        Text(text.isEmpty ? titleKey : "")
                            .sizeCustom(fontSize, fontWeight)
                            .padding(.leading, textPadding)
                            .modifier(ColorModifier(color: fontColor))
                        Spacer()
                    }
                })
    }
    
    
    struct ColorModifier: ViewModifier {
        let color: Color?
        
        func body(content: Content) -> some View {
            if color == nil {
                content
            }
            else {
                content
                    .foregroundColor(color)
            }
        }
    }
}


