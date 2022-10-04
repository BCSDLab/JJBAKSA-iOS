//
//  LogInViewModel.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/27.
//

import Foundation

class LogInViewModel: ObservableObject {
    @Published var account: String = ""
    @Published var password: String = ""
    @Published var isAutoLogIn: Bool = true
    @Published var isLogInFailed: Bool = false
    @Published var token: Token? = nil
    
    //account와 password가 비어있는지 확인.
    var isInfoNotEmpty: Bool {
        !self.account.isEmpty && !self.password.isEmpty
    }
    
    func logIn() {
        UserRepository.logIn(account: account, password: password) { result in
            switch(result) {
            case .success(let value):
                self.token = value
                self.isLogInFailed = false
                print(value)
                break
            case .failure(let error):
                self.isLogInFailed = true
                print(error)
                break
            }
        }
    }
}
