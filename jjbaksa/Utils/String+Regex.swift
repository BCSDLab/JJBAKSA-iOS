//
//  String+Regex.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/11/16.
//

import Foundation

let emailRegex = """
                 ?:[a-z0-9!#$%&'*+/=?^_`{|}~-]
                 +(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)
                 *|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-
                 \\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|
                 \\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")
                 @(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+
                 [a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25
                 [0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}
                 (?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|
                 [a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b
                 \\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|
                 \\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\]
                 """;
let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,16}";


extension String {
    func regexMatches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression) != nil
    }
}
