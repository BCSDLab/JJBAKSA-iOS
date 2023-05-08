//
//  ButtonStyle.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/05/03.
//

import SwiftUI

struct StaticButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
