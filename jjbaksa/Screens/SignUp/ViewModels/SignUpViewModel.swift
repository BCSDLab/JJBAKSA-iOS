//
//  SignUpViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/07.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var currentTab: Int = 0
    @Published var signUpErrorCode: SignUpError = .hold
    // null일땐 아직 요청 안한걸로,
    // false일땐 중복 문제 없는 걸로
    // true일땐 중복이 있는 걸로
    @Published private var _isAccountDuplicated: Bool?

    var isAccountDuplicated: Bool {
        get {
            if let isAccountDuplicated = _isAccountDuplicated {
                return isAccountDuplicated
            }
            return true
        }
        set {
            _isAccountDuplicated = newValue
        }
    }
    
    let limit = 10
    @Published var account: String = ""
    @Published var eMail: String = ""
    @Published var password: String = "" {
        didSet {
            let passwordFilter: String = "[^0-9a-zA-Z~!@#\\$%\\^&\\*]" //password filter 정규 표현식
            let value = oldValue.replacingOccurrences(
                    of: passwordFilter, with: "", options: .regularExpression)
            if value != oldValue {
                self.password = value
            }
        }
    }
    @Published var checkPassword: String = "" {
        didSet {
            let passwordFilter: String = "[^0-9a-zA-Z~!@#\\$%\\^&\\*]" //password filter 정규 표현식
            let value = oldValue.replacingOccurrences(
                    of: passwordFilter, with: "", options: .regularExpression)
            if value != oldValue {
                self.checkPassword = value
            }
        }
    }
    @Published var nickname: String = "" {
        didSet {
            if nickname.count > limit {
                nickname = String(nickname.prefix(limit))
            }
        }
    }
    
    var isInfoIsNotEmpty: Bool {
        !account.isEmpty && !eMail.isEmpty && !password.isEmpty && !checkPassword.isEmpty
    }

    func resetAccountCheck() {
        _isAccountDuplicated = nil
    }

    func isAccountOverlapValid() {
        UserRepository.isOverlap(account: account) { result in
            switch (result) {
            case .success(let value):
                if value != "OK" {
                    self.isAccountDuplicated = true
                    self.signUpErrorCode = .accountOverlapValidError
                } else {
                    self.isAccountDuplicated = false
                    self.signUpErrorCode = .accountOverlapConfirm
                }
                break
            case .failure(let error):
                let responseCode = error.responseCode ?? 0;
                if (responseCode >= 400 && responseCode < 500) {
                    self.isAccountDuplicated = false
                    self.signUpErrorCode = .accountOverlapValidError
                }
                print(error)
                break
            }
        }
    }

    func isAccountOverlapCheck() {
        if self.isAccountDuplicated {
            self.signUpErrorCode = .accountOverlapCheckError
        }
    }

    func isEmailValid() {
        if !self.eMail.regexMatches(emailRegex) {
            self.signUpErrorCode = .emailValidError
        } else if self.signUpErrorCode == .emailValidError {
            self.signUpErrorCode = .hold
        }
    }

    func isPasswordValid() {
        if !self.password.regexMatches(passwordRegex) {
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

    func isSignUpValid() {
        isPasswordEqual()
        isPasswordValid()
        isEmailValid()
        isAccountOverlapCheck()
        if self.signUpErrorCode == .hold || self.signUpErrorCode == .accountOverlapConfirm {
            self.signUpErrorCode = .none
        }
    }
    
    func signUp() {
        UserRepository.signUp(account: account, password: password, email: eMail, nickname: nickname) { result in
            switch(result) {
            case .success(let value):
                print(value)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
