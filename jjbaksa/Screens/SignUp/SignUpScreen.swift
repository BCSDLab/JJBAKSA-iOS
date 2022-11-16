//
//  SignUpScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/09.
//

import SwiftUI

struct SignUpScreen: View {
    @ObservedObject var viewModel = SignUpViewModel()

    var body: some View {
        TabView(selection: self.$viewModel.currentTab) { //TODO: View 이동 시 애니메이션 추가
            SignUpTermsView()
                    .environmentObject(viewModel)
                    .tag(0)
            SignUpInfoView()
                    .environmentObject(viewModel)
                    .tag(1)
            SignUpSuccessView()
                    .environmentObject(viewModel)
                    .tag(2)
        }
    }
}
