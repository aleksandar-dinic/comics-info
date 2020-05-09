//
//  CharactersMock.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct CharactersMock {

    // MARK: - Characters

    static let characters = """
        [
            {
                "identifier": "1",
                "popularity": 1,
                "name": "Flash"
            },{
                "identifier": "2",
                "popularity": 2,
                "name": "Batman"
            },{
                "identifier": "3",
                "popularity": 3,
                "name": "Spider-Man"
            }
        ]
    """.data(using: .utf8)

    // MARK: - Character

    static let character = """
        {
            "identifier": "1",
            "popularity": 1,
            "name": "Flash"
        }
    """.data(using: .utf8)

}
