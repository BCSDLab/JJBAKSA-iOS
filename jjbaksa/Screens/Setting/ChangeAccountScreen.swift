//
//  ChangeAccountScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/03/20.
//

import SwiftUI

struct ChangeAccountScreen: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @ObservedObject var viewModel: SignUpViewModel = SignUpViewModel()
    var body: some View {
        VStack(spacing: 0) {
            Text("현재 아이디")
                .frame(maxWidth: .infinity, alignment: .leading)
                .size16Medium()
                .foregroundColor(.textMain)
                .padding(.leading, 75)
                .padding(.top, 127)
                .padding(.bottom, 7)
            
            Text("@\(rootViewModel.user?.account ?? "")")
                .frame(maxWidth: .infinity, alignment: .leading)
                .size14Regular()
                .foregroundColor(.textMain)
                .padding(.leading, 75)
                .padding(.bottom, 24)
            HStack(spacing: 0) {
                Text("새 아이디")
                    .size16Medium()
                    .foregroundColor(.textMain)
                    .padding(.leading, 75)
                if(viewModel.isAccountDuplicated == false) {
                    HStack(spacing: 0) {
                        Image(systemName: "checkmark.circle")
                        Text("확인되었습니다.")
                    }
                    .size11Regular()
                    .foregroundColor(.green)
                    .padding(.leading, 8)
                } else if(viewModel.isAccountDuplicated == true && viewModel.signUpErrorCode == .accountOverlapValidError) {
                    HStack(spacing: 0) {
                        Image(systemName: "exclamationmark.triangle")
                        Text("이미 존재하는 아이디입니다.")
                    }
                    .size11Regular()
                    .foregroundColor(.main)
                    .padding(.leading, 8)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 10)
            
            ZStack {
                TextField("새 아이디를 입력하세요.", text: $viewModel.account)
                    .onChange(of: viewModel.account) { account in
                        viewModel.resetAccountCheck()
                    }
                    .keyboardType(.asciiCapable)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .frame(width: 225, height: 30)
                    .font(.system(size: 12))
                    .padding(.leading, 10)
                    .background(Capsule().fill(Color.line))
                
                Button(action: { viewModel.isAccountOverlapValid() }) {
                    Text("중복확인")
                        .frame(width: 61, height: 30)
                        .font(.system(size: 11))
                        .foregroundColor(viewModel.isAccountDuplicated ? Color.main : Color.textSub)
                        .background(Capsule()
                            .fill(viewModel.isAccountDuplicated ? Color.textSub : Color.main))
                }
                .padding(.leading, 179)
                Capsule()
                    .strokeBorder(Color.main)
                    .frame(width: 61, height: 30)
                    .padding(.leading, 179)
                
                if viewModel.signUpErrorCode == .accountOverlapCheckError || viewModel.signUpErrorCode == .accountOverlapValidError {
                    Capsule()
                        .strokeBorder(Color.main)
                        .frame(width: 240, height: 30)
                }
            }
            
            Spacer()
            
            if viewModel.isAccountDuplicated == false {
                Button(action: {rootViewModel.changeUserInfo(account: viewModel.account, email: nil, password: nil, nickname: nil)}) {
                    Text("아이디 변경하기")
                        .frame(width: 225, height: 40)
                        .size14Regular()
                        .foregroundColor(.textSub)
                        .background(Capsule().fill(Color.main))
                }
                .padding(.bottom, 125)
            } else {
                Text("아이디 변경하기")
                    .frame(width: 225, height: 40)
                    .size14Regular()
                    .foregroundColor(.textSub)
                    .background(Capsule().fill(Color.base))
                    .padding(.bottom, 125)
            }
        }
    }
}
