//
//  SignUpScreen.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/07.
//

import SwiftUI

struct SignUpInfoView: View {
    @ObservedObject var viewModel = SignUpViewModel()
    @State var showPassword: Bool = false
    @Binding var currentTab: Int
    
    var body: some View {
        NavigationView{
            VStack {
                Spacer()
                HStack {
                    Image(systemName: "circle.fill") //임시 로고
                        .font(Font.system(size: 30))
                        .padding([.trailing], 7)
                    Text("쩝쩝박사")
                        .font(Font.system(size: 18, weight: .bold))
                }
                
                
                switch viewModel.signUpErrorCode {
                case .accountOverlapError:
                    HStack
                    {
                        Image(systemName: "exclamationmark.triangle")
                        Text("이미 존재하는 아이디입니다.")
                    }
                    .font(.system(size: 11))
                    .foregroundColor(Color("MainColor"))
                    .frame(height: 35)
                    .padding(.horizontal, 80)
                    .padding(.top, 37)
                case .emailValidError:
                    HStack
                    {
                        Image(systemName: "exclamationmark.triangle")
                        Text("존재하지 않는 도메인입니다.")
                    }
                    .font(.system(size: 11))
                    .foregroundColor(Color("MainColor"))
                    .frame(height: 35)
                    .padding(.horizontal, 80)
                    .padding(.top, 37)
                case .passwordValidError:
                    HStack
                    {
                        Image(systemName: "exclamationmark.triangle")
                        Text("비밀번호는 문자, 숫자, 특수문자를 포함한 8~16자리로 이루어져야합니다.")
                    }
                    .font(.system(size: 11))
                    .foregroundColor(Color("MainColor"))
                    .frame(height: 35)
                    .padding(.horizontal, 80)
                    .padding(.top, 37)
                case .passwordEqualityError:
                    HStack
                    {
                        Image(systemName: "exclamationmark.triangle")
                        Text("비밀번호가 일치하지 않습니다.")
                    }
                    .font(.system(size: 11))
                    .foregroundColor(Color("MainColor"))
                    .frame(height: 35)
                    .padding(.horizontal, 80)
                    .padding(.top, 37)
                default: HStack
                    {}
                        .font(.system(size: 11))
                        .foregroundColor(Color("MainColor"))
                        .frame(height: 35)
                        .padding(.horizontal, 80)
                        .padding(.top, 37)
                }
                
                Group {
                    Text("아이디")
                        .font(Font.system(size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 24, leading: 82, bottom: 0, trailing: 0))
                    
                    ZStack {
                        TextField("아이디를 입력하세요.", text: $viewModel.account)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                            .frame(width: 227, height: 30)
                            .font(Font.system(size: 12))
                            .padding([.leading], 10)
                            .background(Capsule().fill(Color("LineColor")))
                        
                        if viewModel.isOverlapCheck {
                            Button(action: {viewModel.isAccountOverlapValid()}) {
                                Text("중복확인")
                                    .frame(width: 61, height: 30)
                                    .font(Font.system(size: 11))
                                    .foregroundColor(Color("MainColor"))
                                    .background(Capsule()
                                        .fill(Color("TextSubColor")))
                            }
                            .padding([.leading], 176)
                            Capsule()
                                .strokeBorder(Color("MainColor"))
                                .frame(width: 61, height: 30)
                                .padding([.leading], 176)
                        } else {
                            Text("중복확인")
                                .frame(width: 61, height: 30)
                                .font(Font.system(size: 11))
                                .foregroundColor(Color("TextSubColor"))
                                .background(Capsule()
                                    .fill(Color("MainColor")))
                                .padding([.leading], 176)
                        }
                        
                        if viewModel.signUpErrorCode == .accountOverlapError {
                            Capsule()
                                .strokeBorder(Color("MainColor"))
                                .frame(width: 240, height: 30)
                        }
                    }
                    
                    Text("이메일")
                        .font(Font.system(size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 8, leading: 82, bottom: 0, trailing: 0))
                    
                    ZStack {
                        
                        TextField("이메일을 입력하세요.", text: $viewModel.eMail)
                            .autocorrectionDisabled(true)
                            .autocapitalization(.none)
                            .frame(width: 227, height: 30)
                            .font(Font.system(size: 12))
                            .padding([.leading], 10)
                            .background(Capsule().fill(Color("LineColor")))
                        if viewModel.signUpErrorCode == .emailValidError {
                            Capsule()
                                .strokeBorder(Color("MainColor"))
                                .frame(width: 240, height: 30)
                        }
                    }
                    Text("비밀번호")
                        .font(Font.system(size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 8, leading: 82, bottom: 0, trailing: 0))
                    
                    if showPassword {
                        ZStack{
                            if viewModel.signUpErrorCode == .passwordValidError {
                                Capsule()
                                    .strokeBorder(Color("MainColor"))
                                    .frame(width: 240, height: 30)
                            }
                            TextField("비밀번호를 입력하세요.", text: $viewModel.password)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                                .font(Font.system(size: 12))
                                .padding([.leading], 10)
                            Button(action: { self.showPassword.toggle() }){
                                Image(systemName: "eye")
                                    .foregroundColor(Color("MainColor"))
                                    .font(Font.system(size: 12))
                            }
                            .padding([.leading], 200)
                            
                        }
                        .frame(width: 240, height: 30)
                        .background(Capsule().fill(Color("LineColor")))
                    } else {
                        ZStack{
                            if viewModel.signUpErrorCode == .passwordValidError {
                                Capsule()
                                    .strokeBorder(Color("MainColor"))
                                    .frame(width: 240, height: 30)
                            }
                            SecureField("비밀번호를 입력하세요.", text: $viewModel.password)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                                .font(Font.system(size: 12))
                                .padding([.leading], 10)
                            Button(action: { self.showPassword.toggle() }){
                                Image(systemName: "eye.slash")
                                    .foregroundColor(Color("BaseColor"))
                                    .font(Font.system(size: 12))
                            }
                            .padding([.leading], 200)
                        }
                        .frame(width: 240, height: 30)
                        .background(Capsule().fill(Color("LineColor")))
                    }
                    
                    
                    Text("비밀번호 확인")
                        .font(Font.system(size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 8, leading: 82, bottom: 0, trailing: 0))
                    
                    if showPassword {
                        ZStack{
                            if viewModel.signUpErrorCode == .passwordEqualityError {
                                Capsule()
                                    .strokeBorder(Color("MainColor"))
                                    .frame(width: 240, height: 30)
                            }
                            TextField("비밀번호를 입력하세요.", text: $viewModel.checkPassword)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                                .font(Font.system(size: 12))
                                .padding([.leading], 10)
                            
                            Button(action: { self.showPassword.toggle() }){
                                Image(systemName: "eye")
                                    .foregroundColor(Color("MainColor"))
                                    .font(Font.system(size: 12))
                            }
                            .padding([.leading], 200)
                        }
                        .frame(width: 240, height: 30)
                        .background(Capsule().fill(Color("LineColor")))
                    } else {
                        ZStack{
                            if viewModel.signUpErrorCode == .passwordEqualityError {
                                Capsule()
                                    .strokeBorder(Color("MainColor"))
                                    .frame(width: 240, height: 30)
                            }
                            SecureField("비밀번호를 입력하세요.", text: $viewModel.checkPassword)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                            
                                .font(Font.system(size: 12))
                                .padding([.leading], 10)
                            Button(action: { self.showPassword.toggle() }){
                                Image(systemName: "eye.slash")
                                    .foregroundColor(Color("BaseColor"))
                                    .font(Font.system(size: 12))
                            }
                            .padding([.leading], 200)
                        }
                        .frame(width: 240, height: 30)
                        .background(Capsule().fill(Color("LineColor")))
                    }
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.isSignUpValid()
                    currentTab += 1
                    print(viewModel.signUpErrorCode)
                }) {
                    Text("다음")
                        .frame(width: 227, height: 40)
                        .font(Font.system(size: 14))
                        .foregroundColor(Color("TextSubColor"))
                        .background(Capsule().fill(Color(viewModel.signUpValid ? UIColor(Color("MainColor")) : UIColor(Color("BaseColor")))))
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .scrollDisabled(true)
    }
}
/*
 struct SignUpScreen_Previews: PreviewProvider {
 static var previews: some View {
 SignUpInfoView()
 }
 }
 */
