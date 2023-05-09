//
//  FindPasswordScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/19.
//

import SwiftUI

struct FindPasswordScreen: View {
    @ObservedObject var viewModel: FindPasswordViewModel
    @Binding var path: NavigationPath

    init(path: Binding<NavigationPath>) {
        self.viewModel = FindPasswordViewModel()
        self._path = path
    }
    
    var body: some View {
            VStack(spacing: 0) {
                Text("비밀번호를 찾을 때 사용할\n아이디와 이메일을 입력해주세요.")
                    .frame(width: 238, height: 46)
                    .size18Regular()
                    .padding(.top, 70)
                    .padding(.bottom, 49)
                
                switch viewModel.errorCode {
                case .accountExistError:
                    HStack(spacing: 0) {
                        Image(systemName: "exclamationmark.triangle")
                            .padding(.trailing, 10)
                        Text("아이디가 올바르지 않습니다.")
                    }
                    .size11Regular()
                    .foregroundColor(.main)
                    .frame(height: 35)
                    .padding(.horizontal, 80)
                    .padding(.bottom, 26)
                case .emailExistError:
                    HStack(spacing: 0) {
                        Image(systemName: "exclamationmark.triangle")
                            .padding(.trailing, 10)
                        Text("이메일이 올바르지 않습니다.")
                    }
                    .size11Regular()
                    .foregroundColor(.main)
                    .frame(height: 35)
                    .padding(.horizontal, 80)
                    .padding(.bottom, 26)
                default: HStack
                    {}
                    
                        .frame(height: 35)
                        .padding(.horizontal, 80)
                        .padding(.bottom, 26)
                }
                
                Text("아이디")
                    .size12Medium()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 83)
                    .padding(.bottom, 8)
                ZStack {
                    TextField("아이디를 입력하세요.", text: $viewModel.account)
                        .onChange(of: viewModel.account) { _ in
                            if viewModel.errorCode == .accountExistError {
                                viewModel.errorCode = .hold
                            }
                        }
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .frame(width: 227, height: 30)
                        .font(.system(size: 12))
                        .padding(.leading, 10)
                        .background(Capsule().fill(Color.line))
                    if viewModel.errorCode == .accountExistError {
                        Capsule()
                            .strokeBorder(Color.main)
                            .frame(width: 240, height: 30)
                    }
                        
                }
                .padding(.bottom, 24)
                
                Text("이메일")
                    .size12Medium()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 83)
                    .padding(.bottom, 8)
                ZStack {
                    TextField("이메일을 입력하세요.", text: $viewModel.eMail)
                        .onChange(of: viewModel.eMail) { _ in
                            viewModel.isEmailValid()
                        }
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .frame(width: 227, height: 30)
                        .font(.system(size: 12))
                        .padding(.leading, 10)
                        .background(Capsule().fill(Color.line))
                    if viewModel.errorCode == .emailExistError {
                        Capsule()
                            .strokeBorder(Color.main)
                            .frame(width: 240, height: 30)
                    }
                }
                Spacer()
                
                if viewModel.errorCode == .hold {
                    Button(action: { viewModel.requestVerifyCode() }) {
                        Text("인증번호 보내기")
                            .frame(width: 227, height: 40)
                            .font(.system(size: 14))
                            .foregroundColor(.textSub)
                            .background(Capsule().fill(Color.main))
                    }
                    .padding(.bottom, 140)
                    
                } else {
                    Text("인증번호 보내기")
                        .frame(width: 227, height: 40)
                        .font(.system(size: 14))
                        .foregroundColor(.textSub)
                        .background(Capsule().fill(Color.base))
                        .padding(.bottom, 140)
                }
            }
            .navigationDestination(isPresented: $viewModel.isVerifyCodeSent) {
                InsertCodeScreen(viewModel: viewModel, path: $path)
                    
        }
        .toolbar{ NewBackButton(path: $path) }
        .navigationBarBackButtonHidden()
        
    }
}
