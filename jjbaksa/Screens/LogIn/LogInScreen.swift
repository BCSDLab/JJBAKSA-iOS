//
//  LogInScreen.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/27.
//

import SwiftUI

struct LogInScreen: View {
    @ObservedObject var viewModel: LogInViewModel = LogInViewModel()
    let accountFilter: String = "abcdefghijklmnopqrstuvwxyz0123456789"  //account filter를 위한 문자열
    let passwordFilter: String = "!@#$" //password filter에 추가될 특수문자열
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: "circle.fill") //임시 로고
                    .font(Font.system(size: 30))
                    .padding([.trailing], 7)
                Text("쩝쩝박사")
                    .font(Font.system(size: 18, weight: .bold))
            }

            if viewModel.isLogInFailed == false {
                HStack {
                    Image(systemName: "exclamationmark.triangle")
                    Text("회원이 아니시거나, 아이디 또는 비밀번호를 잘못 입력했습니다.")
                }
                .font(Font.system(size: 11))
                .foregroundColor(Color("MainColor"))
                .frame(maxWidth: 250, alignment: .leading)
                .padding(EdgeInsets(top: 50, leading: 25, bottom: -70, trailing: 0))
            }
            
            Text("로그인")
                .font(Font.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 120, leading: 85, bottom: 0, trailing: 0))
            
            TextField("아이디", text: $viewModel.account)
                .onChange(of: viewModel.account) { newValue in //소문자 알파벳과 숫자를 제외하고 필터
                    let filtered = newValue.filter { accountFilter.contains($0) }
                    if filtered != newValue {
                        self.viewModel.account = filtered
                    }
                    
                }
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .frame(width: 227, height: 30)
                .font(Font.system(size: 12))
                .padding([.leading], 10)
                .background(Capsule().fill(Color("LineColor")))
            
            
            SecureField("비밀번호", text: $viewModel.password)
                .onChange(of: viewModel.password) { newValue in //소문자 알파벳과 숫자, 정해진 특수문자를 제외하고 필터
                    let filtered = newValue.filter { "\(accountFilter)\(passwordFilter)".contains($0) }
                    if filtered != newValue {
                        self.viewModel.password = filtered
                    }
                }
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
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 7, leading: 85, bottom: 51, trailing: 0))
            
            //isInfoNotEmpty가 True일 때만 작동.
            Group{  //Extra argument in call Error 해결을 위한 Grouping
                Button(action: { if viewModel.isInfoNotEmpty { viewModel.logIn() }}) {
                    Text("로그인")          //button이 아닌 label에 frame을 줘서 버튼 클릭 범위를 늘림
                        .frame(width: 227, height: 40)
                        .font(Font.system(size: 14))
                        .foregroundColor(Color("TextSubColor"))
                        .background(Capsule().fill(Color(viewModel.isInfoNotEmpty ? UIColor(Color("MainColor")) : UIColor(Color("BaseColor")))))
                        .padding([.bottom], 7)
                }
                
                Button(action: {()}) { //TODO: 소셜 로그인 페이지 이동
                    Text("소셜 로그인")      //button이 아닌 label에 frame을 줘서 버튼 클릭 범위를 늘림
                        .frame(width: 227, height: 40)
                        .font(Font.system(size: 14))
                        .foregroundColor(Color("MainColor"))
                        .background(Capsule().stroke(Color("MainColor")))
                }
                
                Button(action: {()} ) { //TODO: 회원가입 페이지 이동
                    Text("회원가입")
                        .foregroundColor(Color("MainColor"))
                        .font(Font.system(size: 12))
                        .underline()
                        .padding([.top], 32)
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
