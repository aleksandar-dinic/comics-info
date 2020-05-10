//
//  SpiderManMock.swift
//  Framework
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct SpiderManMock: MockCharacter {

    let identifier = "1"
    private let popularity = 0
    private let name = "Spider-Man"
    private let description = """
        Bitten by a radioactive spider, high school student Peter Parker gained the speed,
        strength and powers of a spider. Adopting the name Spider-Man, Peter hoped to start a career using his
        new abilities. Taught that with great power comes great responsibility, Spidey has vowed to use his powers
        to help people.
        """
    private let thumbnail = "http://i.annihil.us/u/prod/marvel/i/mg/3/50/526548a343e4b.jpg"

    var data: Data? {
        json.data(using: .utf8)
    }

    var json: String {
        """
        {
            "identifier": "\(identifier)",
            "popularity": \(popularity),
            "name": "\(name)",
            "description": "\(description)",
            "thumbnail": "\(thumbnail)"
        }
        """
    }

}
