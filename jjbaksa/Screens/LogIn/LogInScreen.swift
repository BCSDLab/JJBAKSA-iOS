//
//  LogInScreen.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/27.
//

import SwiftUI

struct LogInScreen: View {
    @ObservedObject var viewModel: LogInViewModel = LogInViewModel()
    
    
    var body: some View {
        VStack {
            TextField("아이디", text: $viewModel.account)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
            
            SecureField("비밀번호", text: $viewModel.password)
                .autocorrectionDisabled(true)
                .autocapitalization(.none)
            
            Button(action: viewModel.logIn) {
                Text("로그인")
            }
        }
    }
}

struct LogInScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogInScreen()
    }
}
