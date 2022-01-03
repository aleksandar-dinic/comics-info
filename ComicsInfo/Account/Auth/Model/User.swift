//
//  User.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/12/2021.
//

import Foundation

struct User: Codable {
    
    let identifier: String
    let username: String
    private(set) var email: String?
    private(set) var nickname: String?
    
    mutating func update(with atributes: [UserAttribute]) {
        for atribute in atributes {
            switch atribute {
            case let .email(val):
                email = val
            case let .nickname(val):
                nickname = val
            }
        }
    }
    
}
