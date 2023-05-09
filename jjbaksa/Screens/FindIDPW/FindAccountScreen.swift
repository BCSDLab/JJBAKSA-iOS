//
//  FindAccountScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/18.
//

import SwiftUI

struct FindAccountScreen: View {
    @ObservedObject var viewModel: FindAccountViewModel
    @EnvironmentObject var router: Router
    @Binding var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self.viewModel = FindAccountViewModel()
        self._path = path
    }
    
    var body: some View {
            VStack(spacing: 0) {
                Text("아이디를 찾을 때\n사용할 이메일을 입력해주세요.")
                    .frame(width: 222, height: 46)
                    .size18Regular()
                    .padding(.top, 70)
                    .padding(.bottom, 37)
                
                switch viewModel.errorCode {
                case .emailExistError:
                    HStack(spacing: 0) {
                        Image(systemName: "exclamationmark.triangle")
                            .padding(.trailing, 10)
                        Text("계정이 존재하지 않거나\n이메일 형식이 올바르지 않습니다.")
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
                
                Text("이메일")
                    .size12Medium()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 83)
                    .padding(.bottom, 8)
                ZStack {
                    TextField("이메일을 입력하세요.", text: $viewModel.eMail)
                        .onChange(of: viewModel.eMail) { eMail in
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
                    Button(action: {
                        viewModel.requestVerifyCode()
                    
                    }) {
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
            .onAppear() {
                print(path)
            }
            .navigationDestination(isPresented: $viewModel.isVerifyCodeSent) {
                InsertCodeScreen(viewModel: viewModel, path: $path)
                    
            }
            .toolbar{ NewBackButton(path: $path) }
            .navigationBarBackButtonHidden()
    }
}

