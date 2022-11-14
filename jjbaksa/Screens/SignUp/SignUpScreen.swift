//
//  SignUpScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/09.
//

import SwiftUI

struct SignUpScreen: View {
    @State var currentTab: Int = 0
    var body: some View {
        TabView(selection: $currentTab) {
            SignUpTermsView(currentTab: $currentTab).tag(0)
            SignUpInfoView(currentTab: $currentTab).tag(1)
            SignUpSuccessView().tag(2)
        }
        
        .navigationBarBackButtonHidden(true)
    }
}