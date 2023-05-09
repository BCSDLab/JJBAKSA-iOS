//
//  InsertCodeScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/03/28.
//

import SwiftUI
import ExytePopupView

struct InsertCodeScreen<T: FindProtocol>: View {
    @ObservedObject var viewModel: T
    @FocusState private var focusField: Int?
    @Environment(\.presentationMode) var presentation
    @Binding var path: NavigationPath
    
    init(viewModel: T, path: Binding<NavigationPath>) {
        self.viewModel = viewModel
        self._path = path
        self.focusField = 0
        
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("이메일로 발송된\n인증번호를 입력해 주세요.")
                .frame(width: 222, height: 46)
                .size18Regular()
                .padding(.top, 70)
                .padding(.bottom, 41)
            
            switch viewModel.errorCode {
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
                ForEach(0..<4) { index in
                    let digit = index < viewModel.verifyCode.count ? String(viewModel.verifyCode[viewModel.verifyCode.index(viewModel.verifyCode.startIndex, offsetBy: index)]) : ""
                    TextField("", text: Binding(
                        get: { digit },
                        set: { newValue in
                            if newValue.count <= 1 {
                                if index < viewModel.verifyCode.count {
                                    let start = viewModel.verifyCode.index(viewModel.verifyCode.startIndex, offsetBy: index)
                                    let end = viewModel.verifyCode.index(after: start)
                                    viewModel.verifyCode.replaceSubrange(start..<end, with: newValue)
                                } else if newValue.count == 1 {
                                    viewModel.verifyCode.append(newValue)
                                    focusField! += 1
                                }
                            }
                            
                        }
                    ))
                    .focused($focusField, equals: index)
                    .onChange(of: viewModel.verifyCode) { verifyCode in
                        viewModel.isVerifyCodeValid()
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
            
            Button(action: { viewModel.requestVerifyCode() }) {
                Text("인증번호 재발송")
                    .foregroundColor(.main)
                    .size12Regular()
            }
            
            Spacer()
            
            if viewModel.errorCode == .hold {
                Button(action: { viewModel.sendVerifyCode() }) {
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
        .navigationDestination(isPresented: $viewModel.isVerifyCodeCheckedForPassword) {
            ResetPasswordScreen(token: viewModel.token, path: $path)
                //.environmentObject(router)
        }
        .popup(isPresented: $viewModel.isVerifyCodeCheckedForAccount) {
            AccountPopUpView(eMail: viewModel.eMail, account: viewModel.account, path: $path)
                //.environmentObject(router)
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
    var eMail: String = ""
    var account: String = ""
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 0) {
            Text("아이디 찾기 완료")
                .size18Medium()
                .foregroundColor(.textMain)
                .padding(.top, 32)
                .padding(.bottom, 19)
            
            Text("\(eMail)으로\n가입된 아이디는 \(account)입니다.")
                .size12Regular()
                .foregroundColor(.textMain)
                .padding(.bottom, 28)
            
            Button(action: {path = .init()}) {
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

