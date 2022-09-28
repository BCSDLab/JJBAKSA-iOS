//
//  LogInScreen.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/27.
//

import SwiftUI

struct LogInScreen: View {
    @ObservedObject var viewModel: LogInViewModel = LogInViewModel()
    var isInfoNotEmpty: Bool {  //유저가 아이디 비밀번호 모두 입력했는지.
        return !viewModel.account.isEmpty && !viewModel.password.isEmpty
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "circle.fill") //임시 로고
                    .font(Font.system(size: 30))
                    .padding([.trailing], 7)
                Text("쩝쩝박사")
                    .font(Font.system(size: 18, weight: .bold))
            }
            .padding([.top], 114)
            //이 사이에 로그인 실패 메세지 출력
            
            Text("로그인")
                .font(Font.system(size: 14))
                .padding(EdgeInsets(top: 105, leading: 81, bottom: 0, trailing: 257))
            
            TextField("아이디", text: $viewModel.account)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .frame(width: 227, height: 30)
                .font(Font.system(size: 12))
                .padding([.leading], 10)
                .background(Capsule().fill(Color("LineColor")))
            
            
            SecureField("비밀번호", text: $viewModel.password)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .frame(width: 227, height: 30)
                .font(Font.system(size: 12))
                .padding([.leading], 10)
                .background(Capsule().fill(Color("LineColor")))
            
            HStack {
                ZStack { //SwiftUI 자체 Toggle을 사용하려 했으나 style 설정이 어려워 custom Toggle 제작
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
            .padding(EdgeInsets(top: 7, leading: 81, bottom: 51, trailing: 211))
            
            //isInfoNotEmpty == false 일 때 버튼 작동 안하게.
            Button(action: viewModel.logIn) {
                Text("로그인")
            }
            .frame(width: 227, height: 40)
            .font(Font.system(size: 14))
            .foregroundColor(Color("TextSubColor"))
            .background(Capsule().fill(Color(isInfoNotEmpty ? UIColor(Color("MainColor")) : UIColor(Color("BaseColor")))))
            .padding([.bottom], 7)
            
            //소셜 로그인 기능 삽입.
            Button(action: viewModel.logIn) {
                Text("소셜 로그인")
            }
            .frame(width: 227, height: 40)
            .font(Font.system(size: 14))
            .foregroundColor(Color("MainColor"))
            .background(Capsule().stroke(Color("MainColor")))
            
            //회원가입 button 또는 NavigationLink 기능 삽입
            Text("회원가입")
                .foregroundColor(Color("MainColor"))
                .font(Font.system(size: 12))
                .underline()
                .padding([.top], 32)
                .padding([.bottom], 226)
        }
    }
}


struct LogInScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogInScreen()
    }
}
