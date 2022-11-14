//
//  SignUpViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/07.
//

import Foundation

class SignUpViewModel: ObservableObject {
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
                self.password = value
            }
        }
    }
    
    @Published var isOverlapCheck: Bool = true
    @Published var isOverlap: String = ""
    @Published var signUpValid: Bool = false
    @Published var signUpErrorCode: SignUpError = .none
    
    func isAccountOverlapValid() {
        ExistRepository.isOverlap(account: account) { result in
            switch(result) {
            case .success(let value):
                self.isOverlap = value
                if value != "OK" {
                    self.signUpErrorCode = .accountOverlapError
                } else { self.signUpErrorCode = .none }
                print(value)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func isEmailValid() -> Bool {
        let eMailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" //Email 정규 표현식
        return (self.eMail.range(of:eMailRegex, options: .regularExpression) != nil)
    }
    
    func isPasswordValid() -> Bool {
        let passwordRegex: String = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,}" //Password 정규 표현식
        return (self.password.range(of: passwordRegex, options: .regularExpression) != nil && !(self.password.count >= 16))
    }
    
    
    func isSignUpValid() -> Bool {
        if isOverlap != "OK" {
            self.signUpErrorCode = .accountOverlapError
            return false
        } else if !isEmailValid() {
            self.signUpErrorCode = .emailValidError
            return false
        } else if !isPasswordValid() {
            self.signUpErrorCode = .passwordValidError
            return false
        } else if password != checkPassword {
            self.signUpErrorCode = .passwordEqualityError
            return false
        } else {
            self.signUpErrorCode = .none
            return true
        }
    }
}
