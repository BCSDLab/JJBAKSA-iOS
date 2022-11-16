//
// Created by 정태훈 on 2022/11/15.
//

import Foundation

let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}";
let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,16}";


extension String {
    func regexMatches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression) != nil
    }
}