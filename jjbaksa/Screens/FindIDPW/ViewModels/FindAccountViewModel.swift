//
//  FindAccountViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/18.
//

import Foundation

class FindAccountViewModel: FindProtocol {
    @Published var account: String = ""
    @Published var eMail: String = ""
    @Published var verifyCode: String = ""
    @Published var isVerifyCodeSent: Bool = false
    @Published var token: String = ""
    @Published var errorCode: FindError = .initial
    @Published var isVerifyCodeCheckedForAccount: Bool = false
    var isVerifyCodeCheckedForPassword: Bool = false
    
    func isEmailValid() {
        if eMail.regexMatches(emailRegex) {
            if errorCode == .emailValidError || errorCode == .emailExistError {
                errorCode = .hold
            }
        } else {
            errorCode = .emailValidError
        }
    }
    
    func isVerifyCodeValid() {
        if verifyCode.regexMatches(codeRegex) {
            if errorCode == .codeValidError || errorCode == .codeVerifyError {
                errorCode = .hold
            }
        } else {
            errorCode = .codeValidError
        }
    }
    
    func requestVerifyCode() {
        UserRepository.requestVerifyCodeForAccountFinding(eMail: eMail) { result in
            switch (result) {
            case .success(let value):
                if value == "OK" {
                    self.errorCode = .none
                    self.isVerifyCodeSent = true
                } else {
                    self.errorCode = .emailExistError
                }
                print(value)
                break
            case .failure(let error):
                self.errorCode = .networkError
                print(error)
                break
            }
        }
    }
    
    func sendVerifyCode() {
        UserRepository.sendVerifyCodeForAccountFinding(eMail: eMail, code: verifyCode) { result in
            switch (result) {
            case .success(let value):
                if value.account != nil {
                    self.account = value.account!
                    self.errorCode = .none
                    self.isVerifyCodeCheckedForAccount = true
                } else { self.errorCode = .codeVerifyError }
                print(value)
                break
            case .failure(let error):
                let responseCode = error.responseCode ?? 0;
                if (responseCode >= 400 && responseCode < 500) {
                    self.errorCode = .codeVerifyError
                }
                print(error)
                break
            }
        }
    }
    
}
