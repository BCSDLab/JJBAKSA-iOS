//
//  FindProtocol.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/18.
//

import Foundation

protocol FindProtocol: ObservableObject {
    var account: String { get set }
    var eMail: String { get set }
    var verifyCode: String { get set }
    var isVerifyCodeSent: Bool { get set }
    var errorCode: FindError { get set }
    var token: String { get set }
    var isVerifyCodeCheckedForAccount: Bool { get set }
    var isVerifyCodeCheckedForPassword: Bool { get set }

    
    func isEmailValid()
    func isVerifyCodeValid()
    func requestVerifyCode()
    func sendVerifyCode()
}
