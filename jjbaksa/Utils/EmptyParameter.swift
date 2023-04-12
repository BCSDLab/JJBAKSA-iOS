//
//  EmptyParameter.swift
//  jjbaksa
//
//  Created by 정영준 on 2023/04/06.
//

import Foundation

//public typealias QueryString: Codable = [String: Encodable]

struct QueryString: Codable {
    var parameter: [String]
    var value: [String]
}

struct EmptyParameter: Codable {
    
}
