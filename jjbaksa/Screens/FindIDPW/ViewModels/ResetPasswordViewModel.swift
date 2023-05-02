//
//  ResetPasswordViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/19.
//

import Foundation

class ResetPasswordViewModel: ObservableObject {
    @Published var password: String = ""
    @Published var checkPassword: String = ""
    @Published var errorCode: FindError = .initial
    @Published var isPasswordShow: Bool = false
    @Published var isPasswordReset: Bool = false
    
    var token: String?
    init(token: String) {
        self.token = token
    }
    
    func showPasswordToggle() {
        self.isPasswordShow.toggle()
    }
    
    func isPasswordValid() {
        if password.regexMatches(passwordRegex){
            isPasswordEqual()
            if errorCode == .hold {
                errorCode = .none
            }
        } else {
            errorCode = .passwordValidError
        }
    }
    
    func isPasswordEqual() {
        if password != checkPassword {
            errorCode = .passwordEqualityError
        } else {
            errorCode = .hold
        }
    }
    
    func onChangePassword() {
        if errorCode == .passwordEqualityError || errorCode == .passwordValidError || (errorCode == .initial && !password.isEmpty && !checkPassword.isEmpty){
            errorCode = .hold
        }
    }
    
    func resetPassword() {
        UserRepository.resetPassword(password: password, token: token!) { result in
            switch (result) {
            case .success(let value):
                if value.account != nil {
                    self.isPasswordReset = true
                } else { self.errorCode = .codeVerifyError }
                print(value)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }

}
