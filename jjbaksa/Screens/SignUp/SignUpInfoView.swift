//
//  SignUpScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/07.
//

import SwiftUI

struct SignUpInfoView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    @State var showPassword: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    Image(systemName: "circle.fill") //임시 로고
                            .font(Font.system(size: 30))
                            .padding([.trailing], 7)
                    Text("쩝쩝박사")
                            .size18Bold()
                }

                
                switch viewModel.signUpErrorCode {
                case .accountOverlapCheckError:
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                        Text("아이디 중복확인을 해주세요.")
                    }
                            .size11Regular()
                            .foregroundColor(Color.main)
                            .frame(height: 35)
                            .padding(.horizontal, 80)
                            .padding(.top, 37)
                    
                case .accountOverlapConfirm:
                    HStack {
                        Image(systemName: "checkmark.circle")
                        Text("아이디 중복확인 되었습니다.")
                    }
                            .size11Regular()
                            .foregroundColor(Color.green)
                            .frame(height: 35)
                            .padding(.horizontal, 80)
                            .padding(.top, 37)
                    
                case .accountOverlapValidError:
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                        Text("이미 존재하는 아이디입니다.")
                    }
                            .size11Regular()
                            .foregroundColor(Color.main)
                            .frame(height: 35)
                            .padding(.horizontal, 80)
                            .padding(.top, 37)
                    
                case .emailValidError:
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                        Text("존재하지 않는 도메인입니다.")
                    }
                            .size11Regular()
                            .foregroundColor(Color.main)
                            .frame(height: 35)
                            .padding(.horizontal, 80)
                            .padding(.top, 37)
                    
                case .passwordValidError:
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                        Text("비밀번호는 문자, 숫자, 특수문자를 포함한 8~16자리로 이루어져야합니다.")
                    }
                            .size11Regular()
                            .foregroundColor(Color.main)
                            .frame(height: 35)
                            .padding(.horizontal, 80)
                            .padding(.top, 37)
                    
                case .passwordEqualityError:
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                        Text("비밀번호가 일치하지 않습니다.")
                    }
                            .size11Regular()
                            .foregroundColor(Color.main)
                            .frame(height: 35)
                            .padding(.horizontal, 80)
                            .padding(.top, 37)
                    
                default:
                    HStack {
                    }
                            .size11Regular()
                            .foregroundColor(Color.main)
                            .frame(height: 35)
                            .padding(.horizontal, 80)
                            .padding(.top, 37)
                }
                
                Group {
                    Text("아이디")
                        .size14Regular()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 24, leading: 82, bottom: 0, trailing: 0))
                    
                    ZStack {
                        TextField("아이디를 입력하세요.", text: $viewModel.account)
                            .onChange(of: viewModel.account) { account in
                                viewModel.resetAccountCheck()
                            }
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                            .frame(width: 227, height: 30)
                            .size12Regular()
                            .padding([.leading], 10)
                            .background(Capsule().fill(Color.line))
                        
                        Button(action: { viewModel.isAccountOverlapValid() }) {
                            Text("중복확인")
                                .frame(width: 61, height: 30)
                                .size11Regular()
                                .foregroundColor(viewModel.isAccountDuplicated ? Color.main : Color.textSub)
                                .background(Capsule()
                                    .strokeBorder(Color.main)
                                    .background(Capsule().fill(viewModel.isAccountDuplicated ? Color.textSub : Color.main)))
                        }
                        .padding(.leading, 179)
                        
                        if viewModel.signUpErrorCode == .accountOverlapCheckError || viewModel.signUpErrorCode == .accountOverlapValidError {
                            Capsule()
                                .strokeBorder(Color.main)
                                .frame(width: 240, height: 30)
                        }
                    }
                    
                    Text("이메일")
                        .size14Regular()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 8, leading: 82, bottom: 0, trailing: 0))
                    
                    ZStack {
                        TextField("이메일을 입력하세요.", text: $viewModel.eMail)
                            .onChange(of: viewModel.eMail) { eMail in
                                if viewModel.signUpErrorCode == .emailValidError {
                                    viewModel.isEmailValid()
                                }
                            }
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                            .frame(width: 227, height: 30)
                            .size12Regular()
                            .padding([.leading], 10)
                            .background(Capsule().fill(Color.line))
                        if viewModel.signUpErrorCode == .emailValidError {
                            Capsule()
                                .strokeBorder(Color.main)
                                .frame(width: 240, height: 30)
                        }
                    }
                     
                    Text("비밀번호")
                        .size14Regular()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 8, leading: 82, bottom: 0, trailing: 0))
                    
                    if showPassword {
                        ZStack {
                            if viewModel.signUpErrorCode == .passwordValidError {
                                Capsule()
                                    .strokeBorder(Color.main)
                                    .frame(width: 240, height: 30)
                            }
                            TextField("비밀번호를 입력하세요.", text: $viewModel.password)
                                .onChange(of: viewModel.password) { password in
                                    if viewModel.signUpErrorCode == .passwordValidError {
                                        viewModel.isPasswordValid()
                                    }
                                }
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                                .size12Regular()
                                .padding([.leading], 10)
                            Button(action: { self.showPassword.toggle() }) {
                                Image(systemName: "eye")
                                    .foregroundColor(Color.main)
                                    .size12Regular()
                            }
                            .padding([.leading], 200)
                            
                        }
                        .frame(width: 240, height: 30)
                        .background(Capsule().fill(Color.line))
                    } else {
                        ZStack {
                            if viewModel.signUpErrorCode == .passwordValidError {
                                Capsule()
                                    .strokeBorder(Color.main)
                                    .frame(width: 240, height: 30)
                            }
                            SecureField("비밀번호를 입력하세요.", text: $viewModel.password)
                                .onChange(of: viewModel.password) { password in
                                    if viewModel.signUpErrorCode == .passwordValidError {
                                        viewModel.isPasswordValid()
                                    }
                                }
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                                .size12Regular()
                                .padding([.leading], 10)
                            Button(action: { self.showPassword.toggle() }) {
                                Image(systemName: "eye.slash")
                                    .foregroundColor(.base)
                                    .size12Regular()
                            }
                            .padding([.leading], 200)
                        }
                        .frame(width: 240, height: 30)
                        .background(Capsule().fill(Color.line))
                    }
                    
                    
                    Text("비밀번호 확인")
                        .size14Regular()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 8, leading: 82, bottom: 0, trailing: 0))
                    
                    if showPassword {
                        ZStack {
                            if viewModel.signUpErrorCode == .passwordEqualityError {
                                Capsule()
                                    .strokeBorder(Color.main)
                                    .frame(width: 240, height: 30)
                            }
                            TextField("비밀번호를 입력하세요.", text: $viewModel.checkPassword)
                                .onChange(of: viewModel.checkPassword) { password in
                                    if viewModel.signUpErrorCode == .passwordEqualityError {
                                        viewModel.isPasswordEqual()
                                    }
                                }
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                                .size12Regular()
                                .padding([.leading], 10)
                            
                            Button(action: { self.showPassword.toggle() }) {
                                Image(systemName: "eye")
                                    .foregroundColor(Color.main)
                                    .size12Regular()
                            }
                            .padding([.leading], 200)
                        }
                        .frame(width: 240, height: 30)
                        .background(Capsule().fill(Color.line))
                    } else {
                        ZStack {
                            if viewModel.signUpErrorCode == .passwordEqualityError {
                                Capsule()
                                    .strokeBorder(Color.main)
                                    .frame(width: 240, height: 30)
                            }
                            SecureField("비밀번호를 입력하세요.", text: $viewModel.checkPassword)
                                .onChange(of: viewModel.checkPassword) { password in
                                    if viewModel.signUpErrorCode == .passwordEqualityError {
                                        viewModel.isPasswordEqual()
                                    }
                                }
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                                .size12Regular()
                                .padding([.leading], 10)
                            Button(action: { self.showPassword.toggle() }) {
                                Image(systemName: "eye.slash")
                                    .foregroundColor(.base)
                                    .size12Regular()
                            }
                            .padding([.leading], 200)
                        }
                        .frame(width: 240, height: 30)
                        .background(Capsule().fill(Color.line))
                    }
                    
                }
                Spacer()
                if viewModel.isInfoIsNotEmpty && (viewModel.signUpErrorCode == .none || viewModel.signUpErrorCode == .hold || viewModel.signUpErrorCode == .accountOverlapConfirm) {
                    Button(action: {
                        viewModel.isSignUpValid()
                        if viewModel.signUpErrorCode == .none {
                            viewModel.currentTab += 1
                        }
                        print(viewModel.signUpErrorCode)
                    }) {
                        Text("다음")
                                .frame(width: 227, height: 40)
                                .size14Regular()
                                .foregroundColor(.textSub)
                                .background(Capsule().fill(Color.main))
                    }
                } else {
                    Text("다음")
                            .frame(width: 227, height: 40)
                            .size14Regular()
                            .foregroundColor(.textSub)
                            .background(Capsule().fill(Color.base))
                }

                Spacer()
            }
        }
                .scrollDisabled(true)
    }
}


struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpInfoView()
    }
}

