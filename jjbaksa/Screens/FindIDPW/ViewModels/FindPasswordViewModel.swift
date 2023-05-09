//
//  FindPasswordViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/19.
//

import Foundation

class FindPasswordViewModel: FindProtocol {
    @Published var account: String = ""
    @Published var eMail: String = ""
    @Published var verifyCode: String = ""
    @Published var isVerifyCodeSent: Bool = false
    @Published var errorCode: FindError = .initial
    @Published var token: String = ""
    @Published var isVerifyCodeCheckedForPassword: Bool = false
    var isVerifyCodeCheckedForAccount: Bool = false
    
    
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
        UserRepository.requestVerifyCodeForPasswordFinding(account: account, eMail: eMail) { result in
            switch (result) {
            case .success(let value):
                if value == "OK" {
                    self.errorCode = .none
                    self.isVerifyCodeSent = true
                    print(value)
                } else {
                    if let data = value.data(using: .utf8),
                       let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let code = json["code"] as? Int {
                        switch code {
                        case 3 :
                            self.errorCode = .accountExistError
                            break
                        case 45 :
                            self.errorCode = .emailExistError
                            break
                        default : break
                        }
                    }

                }
                
                break
            case .failure(let error):
                self.errorCode = .networkError
                print(error)
                break
            }
        }
    }
    
    func sendVerifyCode() {
        UserRepository.sendVerifyCodeForPasswordFinding(account: account, eMail: eMail, code: verifyCode) { result in
            switch (result) {
            case .success(let value):
                self.token = value
                self.errorCode = .none
                self.isVerifyCodeCheckedForPassword = true
                print(value)
                break
            case .failure(let error):
                print(error)
                
                break
            }
        }
    }

}
