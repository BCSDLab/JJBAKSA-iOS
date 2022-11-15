//
//  SignUpViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/07.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var signUpErrorCode: SignUpError = .none
    @Published var accountOverlapValue: String = ""
    
    @Published var account: String = "" {
        didSet {
            let accountFilter: String = "[^0-9a-zA-Z]"  //account filter 정규 표현식
            let value = oldValue.replacingOccurrences(
                of: accountFilter, with: "", options: .regularExpression)
            if value != oldValue {
                self.account = value
            }
        }
    }
    
    @Published var eMail: String = "" {
        didSet {
            let eMailFilter: String = "[^0-9a-zA-Z@._%+-]" //Email filter 정규 표현식
            let value = oldValue.replacingOccurrences(
                of: eMailFilter, with: "", options: .regularExpression)
            if value != oldValue {
                self.eMail = value
            }
        }
    }
    
    @Published var password: String = ""{
        didSet {
            let passwordFilter: String = "[^0-9a-zA-Z~!@#\\$%\\^&\\*]" //password filter 정규 표현식
            let value = oldValue.replacingOccurrences(
                                of: passwordFilter, with: "", options: .regularExpression)
            if value != oldValue {
                self.password = value
            }
        }
    }
    
    @Published var checkPassword: String = ""{
        didSet {
            let passwordFilter: String = "[^0-9a-zA-Z~!@#\\$%\\^&\\*]" //password filter 정규 표현식
            let value = oldValue.replacingOccurrences(
                                of: passwordFilter, with: "", options: .regularExpression)
            if value != oldValue {
                self.checkPassword = value
            }
        }
    }
    
    var isInfoisNotEmpty: Bool {
        !self.account.isEmpty && !self.eMail.isEmpty && !self.password.isEmpty && !self.checkPassword.isEmpty
    }
    
    func resetAccountCheck() {
        self.accountOverlapValue = ""
    }
    
    func isAccountOverlapValid() {
        ExistRepository.isOverlap(account: account) { result in
            switch(result) {
            case .success(let value):
                self.accountOverlapValue = value
                if value != "OK" {
                    self.signUpErrorCode = .accountOverlapValidError
                } else {
                    self.signUpErrorCode = .hold
                }
                print(value)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func isAccountOverlapCheck() {
        if self.accountOverlapValue.isEmpty {
            self.signUpErrorCode = .accountOverlapCheckError
        }
    }
    
    func isEmailValid() {
        let eMailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" //Email 정규 표현식
        if (self.eMail.range(of:eMailRegex, options: .regularExpression) != nil) == false {
            self.signUpErrorCode = .emailValidError
        } else if self.signUpErrorCode == .emailValidError {
            self.signUpErrorCode = .hold
        }
    }
    
    func isPasswordValid() {
        let passwordRegex: String = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,}" //Password 정규 표현식
        if (self.password.range(of: passwordRegex, options: .regularExpression) != nil && !(self.password.count >= 16)) == false {
            self.signUpErrorCode = .passwordValidError
        } else if self.signUpErrorCode == .passwordValidError {
            self.signUpErrorCode = .hold
        }
    }
    
    func isPasswordEqual() {
        if self.password != self.checkPassword {
            self.signUpErrorCode = .passwordEqualityError
        } else if self.signUpErrorCode == .passwordEqualityError {
            self.signUpErrorCode = .hold
        }
    }
    
    func isSignUpValid(){
        isPasswordEqual()
        isPasswordValid()
        isEmailValid()
        isAccountOverlapCheck()
        if self.signUpErrorCode == .hold {
            self.signUpErrorCode = .none
        }
    }
}
