//
//  IronManMock.swift
//  Framework
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct IronManMock: MockData {

    let identifier = "4"
    private let popularity = 3
    private let name = "Iron Man"
    private let description = """
        Wounded, captured and forced to build a weapon by his enemies, billionaire industrialist \
        Tony Stark instead created an advanced suit of armor to save his life and escape captivity. Now with a new \
        outlook on life, Tony uses his money and intelligence to make the world a safer, better place as Iron Man.
        """
    private let thumbnail = "IronMan"

    var data: Data? {
        json.data(using: .utf8)
    }

    var json: String {
        """
        { \
        "identifier": "\(identifier)", \
        "popularity": \(popularity), \
        "name": "\(name)", \
        "description": "\(description)", \
        "thumbnail": "\(thumbnail)" \
        }
        """
    }

}
