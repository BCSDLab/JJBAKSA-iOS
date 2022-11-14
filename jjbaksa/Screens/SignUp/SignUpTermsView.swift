//
//  SignUpTermsView.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/09.
//

import SwiftUI

struct SignUpTermsView: View {
    @ObservedObject var viewModel = SignUpViewModel()
    @Binding var currentTab: Int
    var body: some View {
        VStack {
            Spacer()
            Text("This is SignUpTermsView")
            Spacer()
            
            Button(action: {
                currentTab += 1
                print(viewModel.signUpErrorCode)
            }) {
                Text("다음")
                    .frame(width: 227, height: 40)
                    .font(Font.system(size: 14))
                    .foregroundColor(Color("TextSubColor"))
                    .background(Capsule().fill(Color("BaseColor")))
            }
            Spacer()
        }
    }
}
