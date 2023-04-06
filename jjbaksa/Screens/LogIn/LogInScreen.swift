//
//  LogInScreen.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/27.
//

import SwiftUI

struct LogInScreen: View {
    @ObservedObject var viewModel: LogInViewModel = LogInViewModel()
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                HStack {
                    Image(systemName: "circle.fill") //임시 로고
                        .font(.system(size: 30))
                        .padding([.trailing], 7)
                    Text("쩝쩝박사")
                        .font(.system(size: 18, weight: .bold))
                }


                HStack {
                    if viewModel.isLogInFailed {
                        Image(systemName: "exclamationmark.triangle")
                        Text("회원이 아니시거나, 아이디 또는 비밀번호를 잘못 입력했습니다.")
                    }
                }
                .font(.system(size: 11))
                .foregroundColor(.main)
                .frame(height: 35)
                .padding(.horizontal, 80)
                .padding(.top, 37)
                
                
                Text("로그인")
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 24, leading: 82, bottom: 0, trailing: 0))
                
                TextField("아이디", text: $viewModel.account)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .frame(width: 227, height: 30)
                    .font(.system(size: 12))
                    .padding([.leading], 10)
                    .background(Capsule().fill(Color.line))
                
                
                SecureField("비밀번호", text: $viewModel.password)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .frame(width: 227, height: 30)
                    .font(.system(size: 12))
                    .padding([.leading], 10)
                    .background(Capsule().fill(Color.line))
                
                HStack {
                    ZStack {
                        Capsule()
                            .frame(width:24,height:12)
                            .foregroundColor(Color(rootViewModel.isTokenSave ? UIColor(.main) : UIColor(.base)))
                        ZStack{
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.white)
                        }
                        .offset(x: rootViewModel.isTokenSave ? 6 : -6)
                        .animation(.spring())
                    }
                    .onTapGesture {
                        rootViewModel.isTokenSave.toggle()
                    }
                    
                    Text("자동 로그인")
                        .font(.system(size: 11))
                        .foregroundColor(Color(rootViewModel.isTokenSave ? UIColor(.main) : UIColor(.textMain)))
                    
                }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 7, leading: 85, bottom: 51, trailing: 0))
                        .onChange(of: viewModel.token) { token in
                            if (token != nil) {
                                rootViewModel.setToken(token: token!)
                            }
                        }

                //isInfoNotEmpty가 True일 때만 작동.
                Group {  //Extra argument in call Error 해결을 위한 Grouping
                    Button(action: {
                        viewModel.logIn()
                    }) {
                        Text("로그인")          //button이 아닌 label에 frame을 줘서 버튼 클릭 범위를 늘림
                            .frame(width: 227, height: 40)
                            .font(.system(size: 14))
                            .foregroundColor(.textSub)
                            .background(Capsule().fill(Color(viewModel.isInfoNotEmpty ? UIColor(.main) : UIColor(.base))))
                            .padding([.bottom], 7)
                    }

                    Button(action: { () }) { //TODO: 소셜 로그인 페이지 이동
                        Text("소셜 로그인")      //button이 아닌 label에 frame을 줘서 버튼 클릭 범위를 늘림
                            .frame(width: 227, height: 40)
                            .font(.system(size: 14))
                            .foregroundColor(.main)
                            .background(Capsule().stroke(Color.main))
                    }
                    .padding(.bottom, 32)
                    HStack(spacing: 0) {
                        NavigationLink(destination: SignUpScreen()) { //TODO: 회원가입 페이지 이동
                            Text("회원가입")
                                .foregroundColor(.main)
                                .size12Regular()
                                .underline()
                        }
                        
                        Text("|")
                            .foregroundColor(.main)
                            .sizeCustom(9)
                            .padding(.vertical, 8)
                        
                        NavigationLink(destination: FindUserInfoScreen(targetInfo: "아이디")) {
                            Text("아이디 찾기")
                                .foregroundColor(.base)
                                .size12Regular()
                                .underline()
                        }
                        
                        Text("|")
                            .foregroundColor(.main)
                            .sizeCustom(9)
                            .padding(.vertical, 8)
                        
                        NavigationLink(destination: FindUserInfoScreen(targetInfo: "비밀번호")) {
                            Text("비밀번호 찾기")
                                .foregroundColor(.base)
                                .size12Regular()
                                .underline()
                        }
                    }
                }

                Spacer()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}


struct LogInScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogInScreen()
    }
}
