//
//  FindPasswordScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/03/28.
//

import SwiftUI

struct ResetPasswordScreen: View {
    @EnvironmentObject var viewModel: FindViewModel
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack(spacing: 0) {
            Text("새 비밀번호를 설정해 주세요.")
                .frame(width: 222, height: 46)
                .size18Regular()
                .padding(.top, 110)
                .padding(.bottom, 44)
            
            switch viewModel.passwordErrorCode {
            case .passwordValidError:
                HStack
                {
                    Image(systemName: "exclamationmark.triangle")
                    Text("비밀번호는 문자, 숫자, 특수문자를 포함한 8~16자리로 이루어져야합니다.")
                }
                .font(.system(size: 11))
                .foregroundColor(.main)
                .frame(height: 35)
                .padding(.horizontal, 80)
                .padding(.bottom, 50)
            case .passwordEqualityError:
                HStack
                {
                    Image(systemName: "exclamationmark.triangle")
                    Text("비밀번호가 일치하지 않습니다.")
                }
                .font(.system(size: 11))
                .foregroundColor(.main)
                .frame(height: 35)
                .padding(.horizontal, 80)
                .padding(.bottom, 50)
            default: HStack
                {}
                
                    .frame(height: 35)
                    .padding(.horizontal, 80)
                    .padding(.bottom, 50)
            }
            
            Text("비밀번호")
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 16, leading: 83, bottom: 8, trailing: 0))
            
            if viewModel.isPasswordShow {
                ZStack{
                    if viewModel.passwordErrorCode == .passwordValidError {
                        Capsule()
                            .strokeBorder(Color.main)
                            .frame(width: 240, height: 30)
                    }
                    TextField("비밀번호를 입력하세요.", text: $viewModel.password)
                        .onChange(of: viewModel.password) { password in
                            if viewModel.passwordErrorCode == .passwordEqualityError {
                                viewModel.isPasswordEqual()
                            }
                        }
                        .keyboardType(.asciiCapable)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .font(.system(size: 12))
                        .padding(.leading, 10)
                    Button(action: { viewModel.showPasswordToggle() }){
                        Image(systemName: "eye")
                            .foregroundColor(.main)
                            .font(.system(size: 12))
                    }
                    .padding(.leading, 200)
                    
                }
                .frame(width: 240, height: 30)
                .background(Capsule().fill(Color.line))
            } else {
                ZStack{
                    if viewModel.passwordErrorCode == .passwordValidError {
                        Capsule()
                            .strokeBorder(Color.main)
                            .frame(width: 240, height: 30)
                    }
                    SecureField("비밀번호를 입력하세요.", text: $viewModel.password)
                        .onChange(of: viewModel.password) { password in
                            if viewModel.passwordErrorCode == .passwordEqualityError {
                                viewModel.isPasswordEqual()
                            }
                        }
                        .keyboardType(.asciiCapable)
                        .textContentType(.newPassword)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .font(.system(size: 12))
                        .padding(.leading, 10)
                    
                    Button(action: { viewModel.showPasswordToggle() }){
                        Image(systemName: "eye.slash")
                            .foregroundColor(.base)
                            .font(.system(size: 12))
                    }
                    .padding(.leading, 200)
                }
                .frame(width: 240, height: 30)
                .background(Capsule().fill(Color.line))
            }
            
            
            Text("비밀번호 확인")
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 16, leading: 83, bottom: 8, trailing: 0))
            
            if viewModel.isPasswordShow {
                ZStack{
                    if viewModel.passwordErrorCode == .passwordEqualityError {
                        Capsule()
                            .strokeBorder(Color.main)
                            .frame(width: 240, height: 30)
                    }
                    TextField("비밀번호를 입력하세요.", text: $viewModel.checkPassword)
                        .onChange(of: viewModel.checkPassword) { password in
                            if viewModel.passwordErrorCode == .passwordEqualityError {
                                viewModel.isPasswordEqual()
                            }
                        }
                        .keyboardType(.asciiCapable)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .font(.system(size: 12))
                        .padding(.leading, 10)
                    
                    Button(action: { viewModel.showPasswordToggle() }){
                        Image(systemName: "eye")
                            .foregroundColor(.main)
                            .font(.system(size: 12))
                    }
                    .padding(.leading, 200)
                }
                .frame(width: 240, height: 30)
                .background(Capsule().fill(Color.line))
            } else {
                ZStack{
                    if viewModel.passwordErrorCode == .passwordEqualityError {
                        Capsule()
                            .strokeBorder(Color.main)
                            .frame(width: 240, height: 30)
                    }
                    SecureField("비밀번호를 입력하세요.", text: $viewModel.checkPassword)
                        .onChange(of: viewModel.checkPassword) { password in
                            if viewModel.passwordErrorCode == .passwordEqualityError {
                                viewModel.isPasswordEqual()
                            }
                        }
                        .keyboardType(.asciiCapable)
                        .textContentType(.newPassword)
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .font(.system(size: 12))
                        .padding(.leading, 10)
                    Button(action: { viewModel.showPasswordToggle() }){
                        Image(systemName: "eye.slash")
                            .foregroundColor(.base)
                            .font(.system(size: 12))
                    }
                    .padding(.leading, 200)
                }
                .frame(width: 240, height: 30)
                .background(Capsule().fill(Color.line))
            }
            
            Spacer()
            
            if viewModel.passwordErrorCode == .hold {
                Button(action: {
                    viewModel.isPasswordValid()
                    if viewModel.passwordErrorCode == .none {
                        () //TODO: 비밀번호 변경
                    }
                }) {
                    Text("완료")
                        .frame(width: 227, height: 40)
                        .font(.system(size: 14))
                        .foregroundColor(.textSub)
                        .background(Capsule().fill(Color.main))
                }
                .padding(.bottom, 140)
            } else {
                Text("완료")
                    .frame(width: 227, height: 40)
                    .font(.system(size: 14))
                    .foregroundColor(.textSub)
                    .background(Capsule().fill(Color.base))
                    .padding(.bottom, 140)
            }
        }
        .popup(isPresented: $viewModel.isPopUpShow) {
            PasswordPopUpView()
                .environmentObject(viewModel)
        } customize: {
            $0
                .type(.default)
                .position(.bottom)
                .animation(.spring())
                .closeOnTapOutside(false)
                .backgroundColor(.black.opacity(0.35))
        }
        
        .toolbar{ BackButton(presentation: presentation) }
        .navigationBarBackButtonHidden()
    }
}


struct PasswordPopUpView: View {
    @EnvironmentObject var viewModel: FindViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Text("비밀번호 찾기 완료")
                .size18Medium()
                .foregroundColor(.textMain)
                .padding(.top, 24)
                .padding(.bottom, 24)
            
            Text("재설정된 비밀번호로 다시 로그인해 주세요.")
                .size12Regular()
                .foregroundColor(.textMain)
                .padding(.bottom, 31)
            
            Button(action: {()}) { //TODO: 로그인화면으로 돌아가기
                Text("완료")
                    .frame(width: 227, height: 40)
                    .font(.system(size: 14))
                    .foregroundColor(.textSub)
                    .background(Capsule().fill(Color.main))
            }
            .padding(.bottom, 24)
        }
        .frame(width: 309, height: 196)
        .background(Color.textSub)
        .cornerRadius(20)
        
    }
}



