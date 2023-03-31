//
//  InsertCodeScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/03/28.
//

import SwiftUI
import ExytePopupView

struct InsertCodeScreen: View {
    @EnvironmentObject var viewModel: FindViewModel
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack(spacing: 0) {
            Text("이메일로 발송된\n인증번호를 입력해 주세요.")
                .frame(width: 222, height: 46)
                .size18Regular()
                .padding(.top, 110)
                .padding(.bottom, 41)
            
            switch viewModel.codeErrorCode {
            case .codeVerifyError:
                HStack(spacing: 0) {
                    Image(systemName: "exclamationmark.triangle")
                        .padding(.trailing, 10)
                    Text("인증번호가 올바르지 않습니다.")
                }
                .size11Regular()
                .foregroundColor(.main)
                .frame(height: 35)
                .padding(.horizontal, 80)
                .padding(.bottom, 59)
            default: HStack
                {}
                    .frame(height: 35)
                    .padding(.horizontal, 80)
                    .padding(.bottom, 59)
            }
            
            HStack(spacing: 0) {
                ForEach(0..<4) { index in   //TODO: 입력 시 자동으로 focus 변경
                    let digit = index < viewModel.code.count ? String(viewModel.code[viewModel.code.index(viewModel.code.startIndex, offsetBy: index)]) : ""
                    TextField("", text: Binding(
                        get: { digit },
                        set: { newValue in
                            if newValue.count <= 1 {
                                if index < viewModel.code.count {
                                    let start = viewModel.code.index(viewModel.code.startIndex, offsetBy: index)
                                    let end = viewModel.code.index(after: start)
                                    viewModel.code.replaceSubrange(start..<end, with: newValue)
                                } else if newValue.count == 1 {
                                    viewModel.code.append(newValue)
                                }
                            }
                        }
                    ))
                    .onChange(of: viewModel.code) { code in
                        viewModel.isCodeValid()
                    }
                    .keyboardType(.numberPad)
                    .frame(width: 50, height: 58)
                    .sizeCustom(20)
                    .background(Color.line)
                    .multilineTextAlignment(.center)
                    .cornerRadius(8)
                    .padding(.horizontal, 4)
                    .padding(.bottom, 24)
                }
            }
            
            Button(action: { viewModel.sendCertCode() }) {
                Text("인증번호 재발송")
                    .foregroundColor(.main)
                    .size12Regular()
            }
            
            Spacer()
            
            if viewModel.codeErrorCode == .hold {
                Button(action: {
                    if viewModel.targetInfo == "아이디" {
                        viewModel.verifyAccountCertCode() }
                    else if viewModel.targetInfo == "비밀번호" {
                        viewModel.verifyPasswordCertCode()
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
        .navigationDestination(isPresented: $viewModel.isResetPasswordScreenShow) {
            ResetPasswordScreen()
                .environmentObject(viewModel)
        
        }
        .popup(isPresented: $viewModel.isPopUpShow) {
            AccountPopUpView()
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


struct AccountPopUpView: View {
    @EnvironmentObject var viewModel: FindViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Text("아이디 찾기 완료")
                .size18Medium()
                .foregroundColor(.textMain)
                .padding(.top, 32)
                .padding(.bottom, 19)
            
            Text("\(viewModel.eMail)으로\n가입된 아이디는 \(viewModel.user?.account ?? "")입니다.")
                .size12Regular()
                .foregroundColor(.textMain)
                .padding(.bottom, 28)
            
            Button(action: {()}) { //TODO: 로그인화면으로 돌아가기
                Text("확인")
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

