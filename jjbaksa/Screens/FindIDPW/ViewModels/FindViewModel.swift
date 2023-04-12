//
//  FindViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/03/28.
//

import Foundation

class FindViewModel: ObservableObject {
    //TODO: 하나의 ViewModel에 치중된건 아닌지..?
    @Published var eMail: String = ""
    @Published var code: String = ""
    @Published var account: String = ""
    @Published var password: String = ""
    @Published var checkPassword: String = ""
    @Published var emailErrorCode: FindError = .emailValidError
    @Published var codeErrorCode: FindError = .codeValidError
    @Published var passwordErrorCode: FindError = .passwordEqualityError
    @Published var isInsertCodeScreenShow: Bool = false
    @Published var isResetPasswordScreenShow: Bool = false
    @Published var isPopUpShow: Bool = false
    @Published var isPasswordShow: Bool = false
    @Published var user: User?
    @Published var targetInfo: String = ""
    @Published var token: String = ""
    
    func setTargetInfo(target: String) {
        self.targetInfo = target
    }
    
    func isEmailValid() {
        if eMail.regexMatches(emailRegex) {
            if emailErrorCode == .emailValidError || emailErrorCode == .emailExistError {
                emailErrorCode = .hold
            }
        } else {
            emailErrorCode = .emailValidError
        }
    }
    
    func isCodeValid() {
        if code.regexMatches(codeRegex) {
            if codeErrorCode == .codeValidError || codeErrorCode == .codeVerifyError {
                codeErrorCode = .hold
            }
        } else {
            codeErrorCode = .codeValidError
        }
    }
    
    func showPasswordToggle() {
        self.isPasswordShow.toggle()
    }
    
    func isPasswordValid() {
        if password.regexMatches(passwordRegex){
            isPasswordEqual()
            if passwordErrorCode == .hold {
                passwordErrorCode = .none
            }
        } else {
            passwordErrorCode = .passwordValidError
        }
    }
    
    func isPasswordEqual() {
        if password != checkPassword {
            passwordErrorCode = .passwordEqualityError
        } else {
            passwordErrorCode = .hold
        }
    }
    
    func sendCertCode() {
        UserRepository.sendCertCode(eMail: eMail) { result in
            switch (result) {
            case .success(let value):
                if value == "OK" {
                    self.emailErrorCode = .none
                    self.isInsertCodeScreenShow = true
                } else {
                    self.emailErrorCode = .emailExistError
                }
                print(value)
                break
            case .failure(let error):
                //let responseCode = error.responseCode ?? 0;
                self.emailErrorCode = .networkError
                
                print(error)
                break
            }
        }
    }
    
    func verifyAccountCertCode() {
        UserRepository.findAccount(eMail: eMail, code: code) { result in
            switch (result) {
            case .success(let value):
                if value.account != nil {
                    self.user = value
                    self.codeErrorCode = .none
                    self.isPopUpShow = true
                } else { self.codeErrorCode = .codeVerifyError }
                print(value)
                break
            case .failure(let error):
                let responseCode = error.responseCode ?? 0;
                if (responseCode >= 400 && responseCode < 500) {
                    self.codeErrorCode = .codeVerifyError
                }
                print(error)
                break
            }
        }
    }
    
    func verifyPasswordCertCode() {
        let request: FindPasswordRequest = FindPasswordRequest(account: self.account, email: self.eMail, code: self.code)
        UserRepository.findPassword(request: request) { result in
            switch (result) {
            case .success(let value):
                self.token = value
                self.isResetPasswordScreenShow = true
                print(value)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func resetPassword() {
        UserRepository.changePassword(password: password) { result in
            switch (result) {
            case .success(let value):
                if value.account != nil {
                    self.user = value
                    self.isPopUpShow = true
                } else { self.codeErrorCode = .codeVerifyError }
                print(value)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
