//
//  PasswordFilter.swift
//  jjbaksa
//
//  Created by 정영준 on 2022/10/01.
//

import Foundation

class PasswordFilter: ObservableObject {    //password의 input을 filter하기위한 class
    let filterString: String = "abcdefghijklmnopqrstuvwxyz0123456789!@#"
    @Published var value: String = "" {
        didSet {
            let filtered = value.filter { filterString.contains($0) }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
