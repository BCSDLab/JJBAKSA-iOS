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
    
    @Published var token: Token? = nil
    
    func logIn() {
        UserRepository.logIn(account: account, password: password) { result in
            switch(result) {
            case .success(let value):
                self.token = value
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
