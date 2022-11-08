//
//  LogInViewModel.swift
//  jjbaksa
//
//  Created by 정태훈 on 2022/09/27.
//

import Foundation

class LogInViewModel: ObservableObject {
    let accountFilter: String = "[^0-9a-zA-Z]"  //account filter 정규 표현식
    let passwordFilter: String = "[^0-9a-zA-Z~!@#\\$%\\^&\\*]" //password filter 정규 표현식
    
    @Published var account: String = "" {
        didSet {
            let value = oldValue.replacingOccurrences(
                                of: accountFilter, with: "", options: .regularExpression)
            if value != oldValue {
                self.account = value
            }
        }
    }
    @Published var password: String = "" {
        didSet {
            let value = oldValue.replacingOccurrences(
                                of: passwordFilter, with: "", options: .regularExpression)
            if value != oldValue {
                self.password = value
            }
        }
    }
    @Published var isAutoLogIn: Bool = true
    @Published var isLogInFailed: Bool = false
    @Published var token: Token? = nil
    
    //account와 password가 비어있는지 확인.
    var isInfoNotEmpty: Bool {
        !self.account.isEmpty && !self.password.isEmpty
    }
    
    func logIn() {
        if(isInfoNotEmpty) {
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
        } else {
            // TODO: 모두 입력되지 않을 경우 에러 표시
        }
    }
}
