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
    case accountOverlapConfirm // 중복 확인되었을 때
    case emailValidError
    case passwordValidError
    case passwordEqualityError
    
    // 대기 상태
    case hold
    // 오류 없음
    case none
}
