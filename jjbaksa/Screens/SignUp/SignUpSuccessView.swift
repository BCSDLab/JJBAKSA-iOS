//
//  SignUpSuccessView.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/09.
//

import SwiftUI

struct SignUpSuccessView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack {
                Image(systemName: "circle.fill") //임시 로고
                    .font(.system(size: 30))
                    .padding(.trailing, 7)
                Text("쩝쩝박사")
                    .size18Bold()
            }
            Text("🎉")
                .font(.system(size: 50))
                .padding(.top, 101)
                .padding(.bottom, 11)
            
            Text("회원가입을 축하합니다!")
                .size16Bold()
            Text("당신을 어떻게 부르면 좋을까요?")
                .size14Regular()
                .padding(.bottom, 47)
            
            
            TextField("입력하세요.", text: $viewModel.nickname)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .multilineTextAlignment(.center)
                .frame(width: 227, height: 30)
                .size14Regular()
                .background(Capsule().fill(Color.line))
                .padding(.bottom, 161)
            
            if !viewModel.nickname.isEmpty {
                Button(action: {viewModel.signUp()}) {
                    Text("완료")
                        .frame(width: 227, height: 40)
                        .size14Regular()
                        .foregroundColor(.textSub)
                        .background(Capsule().fill(Color.main))
                }
                
            } else {
                Text("완료")
                    .frame(width: 227, height: 40)
                    .size14Regular()
                    .foregroundColor(.textSub)
                    .background(Capsule().fill(Color.base))
            }
            Spacer()
        }
    }
}

struct SignUpSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpSuccessView()
    }
}

