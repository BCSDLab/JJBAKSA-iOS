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
        VStack(spacing: 0) {
            Spacer()
            HStack {
                Image(systemName: "circle.fill") //임시 로고
                    .font(.system(size: 30))
                    .padding(.trailing, 7)
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
            .foregroundColor(Color("MainColor"))
            .frame(height: 35)
            .padding(.horizontal, 80)
            .padding(.top, 53)

            
            Text("로그인")
                .font(Font.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 24, leading: 86, bottom: 7, trailing: 0))
            
            TextField("아이디", text: $viewModel.account)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .frame(width: 227, height: 30)
                .font(.system(size: 12))
                .padding(.leading, 10)
                .background(Capsule().fill(Color("LineColor")))
                .padding(.bottom, 10)
            
            SecureField("비밀번호", text: $viewModel.password)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .frame(width: 227, height: 30)
                .font(.system(size: 12))
                .padding(.leading, 10)
                .background(Capsule().fill(Color("LineColor")))
                .padding(.bottom, 16)
            
            HStack {
                ZStack {
                    Capsule()
                        .frame(width:24,height:12)
                        .foregroundColor(Color(viewModel.isAutoLogIn ? UIColor(Color("MainColor")) : UIColor(Color("BaseColor"))))
                    ZStack{
                        Circle()
                            .frame(width:10, height:10)
                            .foregroundColor(.white)
                    }
                    .offset(x: viewModel.isAutoLogIn ? 6 : -6)
                    .animation(.spring())
                }
                .onTapGesture {
                    self.viewModel.isAutoLogIn.toggle()
                }
                
                Text("자동 로그인")
                    .font(Font.system(size: 11))
                    .foregroundColor(Color(viewModel.isAutoLogIn ? UIColor(Color("MainColor")) : UIColor(Color("TextMainColor"))))
                    
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 85, bottom: 41, trailing: 0))
            .onChange(of: self.viewModel.token) { token in
                if(token != nil) {
                    self.rootViewModel.loadToken(token: token!)
                }
            }
            
            //isInfoNotEmpty가 True일 때만 작동.
            Group{  //Extra argument in call Error 해결을 위한 Grouping
                Button(action: {
                    viewModel.logIn()
                }) {
                    Text("로그인")          //button이 아닌 label에 frame을 줘서 버튼 클릭 범위를 늘림
                        .frame(width: 227, height: 40)
                        .font(Font.system(size: 14))
                        .foregroundColor(Color("TextSubColor"))
                        .background(Capsule().fill(Color(viewModel.isInfoNotEmpty ? UIColor(Color("MainColor")) : UIColor(Color("BaseColor")))))
                        
                }
                .padding(.bottom, 16)

                Button(action: {()}) { //TODO: 소셜 로그인 페이지 이동
                    Text("소셜 로그인")      //button이 아닌 label에 frame을 줘서 버튼 클릭 범위를 늘림
                        .frame(width: 227, height: 40)
                        .font(Font.system(size: 14))
                        .foregroundColor(Color("MainColor"))
                        .background(Capsule().stroke(Color("MainColor")))
                }
                .padding(.bottom, 32)
                
                Button(action: {()} ) { //TODO: 회원가입 페이지 이동
                    Text("회원가입")
                        .foregroundColor(Color("MainColor"))
                        .font(Font.system(size: 12))
                        .underline()
                }
                
            }
            
            Spacer()
        }
    }
}


struct LogInScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogInScreen()
    }
}
