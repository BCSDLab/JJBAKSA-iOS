//
//  SignUpViewModel.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/07.
//

import Foundation

class SignUpViewModel: ObservableObject {
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
    
    @Published var currentTab: Int = 0
    @Published var account: String = ""
    @Published var eMail: String = ""
    @Published var password: String = ""
    @Published var checkPassword: String = ""
    
    var isInfoIsNotEmpty: Bool {
        !account.isEmpty && !eMail.isEmpty && !password.isEmpty && !checkPassword.isEmpty
    }

    func resetAccountCheck() {
        _isAccountDuplicated = nil
    }

    func isAccountOverlapValid() {
        let parameters: QueryString = ["account": account]
        UserRepository.isOverlap(parameters: parameters) { result in
            switch (result) {
            case .success(let value):
                if value != "OK" {
                    self.isAccountDuplicated = true
                    self.signUpErrorCode = .accountOverlapValidError
                } else {
                    self.isAccountDuplicated = false
                    self.signUpErrorCode = .hold
                }
                break
            case .failure(let error):
                let responseCode = error.responseCode ?? 0;
                if (responseCode >= 400 && responseCode < 500) {
                    self.isAccountDuplicated = true
                    self.signUpErrorCode = .accountOverlapValidError
                }
                print(error)
                break
            }
        }
    }

    func isAccountOverlapCheck() {
        if isAccountDuplicated {
            signUpErrorCode = .accountOverlapCheckError
        }
    }

    func isEmailValid() {
        if eMail.regexMatches(emailRegex) {
            signUpErrorCode = .emailValidError
        } else if signUpErrorCode == .emailValidError {
            signUpErrorCode = .hold
        }
    }

    func isPasswordValid() {
        if password.regexMatches(passwordRegex) {
            signUpErrorCode = .passwordValidError
        } else if signUpErrorCode == .passwordValidError {
            signUpErrorCode = .hold
        }
    }

    func isPasswordEqual() {
        if password != checkPassword {
            signUpErrorCode = .passwordEqualityError
        } else if signUpErrorCode == .passwordEqualityError {
            signUpErrorCode = .hold
        }
    }

    func isSignUpValid() {
        isPasswordEqual()
        isPasswordValid()
        isEmailValid()
        isAccountOverlapCheck()
        if signUpErrorCode == .hold {
            signUpErrorCode = .none
        }
    }
}
