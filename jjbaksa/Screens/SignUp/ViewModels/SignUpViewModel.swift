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
    @Published var errorCode: Int = 0
    @Published var signUpValid: Bool = false
    
    func isAccountOverlapValid() -> Bool {
        //TODO: 아이디 중복 검사
            return true
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
        if !isAccountOverlapValid() {
            self.errorCode = 1
            return false
        } else if !isEmailValid() {
            self.errorCode = 2
            return false
        } else if !isPasswordValid() {
            self.errorCode = 3
            return false
        } else if password != checkPassword {
            self.errorCode = 4
            return false
        } else {
            self.errorCode = 0
            return true
        }
    }
}
