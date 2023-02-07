//
//  SocialLogIn.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/02/01.
//


import SwiftUI
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

struct SocialLogInScreen: View {
    var body: some View {
        VStack (spacing: 0){
            Spacer()
            
            Text("소셜 계정으로 로그인")
                .font(.system(size: 18, weight: .bold))
                .padding(.bottom, 128)
            //TODO: 로고 삽입, 색 지정
            Group{
                
                Button(action: {()}) {
                    HStack {
                        Image(systemName: "circle.fill") //임시 로고
                            .font(.system(size: 20))
                            .foregroundColor(Color("TextSubColor"))
                            .padding(.leading, 18)
                            .padding(.trailing, 33)
                        Text("Apple로 로그인")
                            .font(.system(size: 14))
                            .foregroundColor(Color("TextSubColor"))

                    }
                    
                    .frame(width: 227, height: 48, alignment: .leading)
                    .background(Capsule().fill(Color.black))
                    
                    

                }
                .padding(.bottom, 24)
                
                Button(action: {()}) {
                    HStack {
                        Image(systemName: "circle.fill") //임시 로고
                            .font(.system(size: 20))
                            .foregroundColor(Color("TextMainColor"))
                            .padding(.leading, 18)
                            .padding(.trailing, 33)
                        Text("Google로 로그인")
                            .font(.system(size: 14))
                            .foregroundColor(Color("TextMainColor"))

                    }
                    .frame(width: 227, height: 48, alignment: .leading)
                    .background(Capsule().strokeBorder(Color("BaseColor")))
                }
                .padding(.bottom, 24)
                
                Button(action: {()}) {
                    HStack {
                        Image(systemName: "circle.fill") //임시 로고
                            .font(.system(size: 20))
                            .foregroundColor(Color("TextSubColor"))
                            .padding(.leading, 18)
                            .padding(.trailing, 28)
                        Text("네이버로 로그인")
                            .font(.system(size: 14))
                            .foregroundColor(Color("TextSubColor"))

                    }
                    .frame(width: 227, height: 48, alignment: .leading)
                    .background(Capsule().fill(Color.green))
                }
                .padding(.bottom, 24)
                
                //Kakao Login
                Button(action: { if (UserApi.isKakaoTalkLoginAvailable()) {
                    UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                        print(oauthToken)
                        print(error)
                    }
                } else {
                    UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                        print(oauthToken)
                        print(error)
                    }
                }}) {
                    HStack {
                        Image(systemName: "circle.fill") //임시 로고
                            .font(.system(size: 20))
                            .foregroundColor(Color("TextMainColor"))
                            .padding(.leading, 18)
                            .padding(.trailing, 28)
                        Text("카카오로 로그인")
                            .font(.system(size: 14))
                            .foregroundColor(Color("TextMainColor"))

                    }
                    .frame(width: 227, height: 48, alignment: .leading)
                    .background(Capsule().fill(Color.yellow))
                    
                }
                .padding(.bottom, 24)
            }
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

struct SocialLogInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SocialLogInScreen()
    }
}
