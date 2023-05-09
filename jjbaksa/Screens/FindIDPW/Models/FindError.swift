//
//  FindError.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/03/28.
//

import Foundation

enum FindError {
    case initial
    case accountExistError
    case emailValidError
    case emailExistError
    case codeValidError
    case codeVerifyError
    case passwordValidError
    case passwordEqualityError
    case networkError
    case hold
    //대기 상태.
    case none
    //오류 없음.
}
