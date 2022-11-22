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
        TabView(selection: $viewModel.currentTab) {
            SignUpTermsView().tag(0).contentShape(Rectangle())
                    .gesture(DragGesture())
                    .environmentObject(viewModel)
            SignUpInfoView().tag(1).contentShape(Rectangle())
                    .gesture(DragGesture())
                    .environmentObject(viewModel)
            SignUpSuccessView().tag(2).contentShape(Rectangle())
                    .gesture(DragGesture())
        }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.default, value: viewModel.currentTab)
                .navigationBarBackButtonHidden(true)
    }
}