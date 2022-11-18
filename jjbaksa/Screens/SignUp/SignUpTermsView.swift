//
//  SignUpTermsView.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/09.
//

import SwiftUI

struct SignUpTermsView: View {
    @EnvironmentObject var viewModel: SignUpViewModel

    var body: some View {
        VStack {
            Spacer()
            Text("This is SignUpTermsView")
            Spacer()
            
            Button(action: {
                viewModel.currentTab += 1
                print(viewModel.signUpErrorCode)
            }) {
                Text("다음")
                    .frame(width: 227, height: 40)
                    .font(.system(size: 14))
                    .foregroundColor(.textSub)
                    .background(Capsule().fill(Color.base))
            }
            Spacer()
        }
    }
}
