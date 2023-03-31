//
//  FindAccountScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/03/28.
//

import SwiftUI

struct FindUserInfoScreen: View {
    @ObservedObject var viewModel: FindViewModel = FindViewModel()
    @Environment(\.presentationMode) var presentation
    var targetInfo: String
    
    var body: some View {
        
            VStack(spacing: 0) {
                Text("\(targetInfo)를 찾을 때\n사용할 이메일을 입력해주세요.")
                    .frame(width: 222, height: 46)
                    .size18Regular()
                    .padding(.top, 110)
                    .padding(.bottom, 37)
                
                switch viewModel.emailErrorCode {
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
                    if viewModel.emailErrorCode == .emailExistError {
                        Capsule()
                            .strokeBorder(Color.main)
                            .frame(width: 240, height: 30)
                    }
                }
                Spacer()
                
                if viewModel.emailErrorCode == .hold {
                    Button(action: {
                        viewModel.sendCertCode()
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
                viewModel.setTargetInfo(target: targetInfo)
            }
            .navigationDestination(isPresented: $viewModel.isInsertCodeScreenShow) {
                InsertCodeScreen()
                    .environmentObject(viewModel)
            
        }
        .toolbar{ BackButton(presentation: presentation) }
        .navigationBarBackButtonHidden()
        
    }
}

