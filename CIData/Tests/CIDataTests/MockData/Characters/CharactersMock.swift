//
//  CharactersMock.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct Domain.Character
@testable import struct CIData.Character
import Foundation

struct CharactersMock {

    // MARK: - Characters

    static let characters = [
        CIData.Character(identifier: "1", popularity: 1, name: "Flash",
                         thumbnail: nil, description: nil, series: []),
        CIData.Character(identifier: "2", popularity: 2, name: "Batman",
                         thumbnail: nil, description: nil, series: []),
        CIData.Character(identifier: "3", popularity: 3, name: "Spider-Man",
                         thumbnail: nil, description: nil, series: [])
    ]

    static let domainCharacters = [
        Domain.Character(identifier: "1", popularity: 1, name: "Flash", thumbnail: nil, description: nil),
        Domain.Character(identifier: "2", popularity: 2, name: "Batman", thumbnail: nil, description: nil),
        Domain.Character(identifier: "3", popularity: 3, name: "Spider-Man", thumbnail: nil, description: nil)
    ]

    static let charactersData = """
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

    static let charactersBadData = """
        [
            {
                "identifier": "1",
                "popularity": 1,
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

    static let character = CIData.Character(
        identifier: "1",
        popularity: 1,
        name: "Flash",
        thumbnail: nil,
        description: nil,
        series: []
    )

    static let domainCharacter = Domain.Character(
        identifier: "1",
        popularity: 1,
        name: "Flash",
        thumbnail: nil,
        description: nil
    )

    static let characterData = """
        {
            "identifier": "1",
            "popularity": 1,
            "name": "Flash"
        }
    """.data(using: .utf8)

    static let characterBadData = """
        {
            "identifier": "1",
            "popularity": 1,
        }
    """.data(using: .utf8)

}
