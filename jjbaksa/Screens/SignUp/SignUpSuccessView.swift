//
//  SignUpSuccessView.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/09.
//

import SwiftUI

struct SignUpSuccessView: View {
    @State var nickname: String = ""
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack {
                Image(systemName: "circle.fill") //임시 로고
                    .sizeCustom(30)
                    .padding(.trailing, 7)
                Text("쩝쩝박사")
                    .size18Bold()
            }
            Text("🎉")
                .sizeCustom(50)
                .padding(.top, 101)
                .padding(.bottom, 11)
            
            Text("회원가입을 축하합니다!")
                .size14Regular()
            Text("당신을 어떻게 부르면 좋을까요?")
                .size14Regular()
                .padding(.bottom, 47)
            
            
            TextField("입력하세요.", text: $nickname)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
                .multilineTextAlignment(.center)
                .frame(width: 227, height: 30)
                .size14Regular()
                .background(Capsule().fill(Color.line))
                .padding(.bottom, 161)
            
            Button(action: {()}) {
                Text("완료")
                    .frame(width: 227, height: 40)
                    .size14Regular()
                    .foregroundColor(.textSub)
                    .background(Capsule().fill(Color.main))
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

