//
//  SignUpError.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/09.
//

import Foundation

enum SignUpError {
    case accountOverlapValidError
    case accountOverlapCheckError
    case emailValidError
    case passwordValidError
    case passwordEqualityError
    case hold
    //대기 상태.
    case none
    //오류 없음.
}
