//
//  CharactersMock.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct Domain.Character
@testable import struct Comics_Info__Development_.Character
import Foundation

struct CharactersMock {
    
    static let character1 = Comics_Info__Development_.Character.make(identifier: "1", popularity: 0, name: "Name")

    static let character2 = Comics_Info__Development_.Character.make(identifier: "2", popularity: 0, name: "Name")

    // MARK: - Characters

    static let characters = [
        Comics_Info__Development_.Character.make(identifier: "1", popularity: 1, name: "Flash"),
        Comics_Info__Development_.Character.make(identifier: "2", popularity: 2, name: "Batman"),
        Comics_Info__Development_.Character.make(identifier: "3", popularity: 3, name: "Spider-Man")
    ]

    static let domainCharacters = [
        Domain.Character(
            identifier: "1",
            popularity: 1,
            name: "Flash",
            thumbnail: nil,
            description: nil,
            realName: nil,
            aliases: nil,
            birth: nil,
            mainSeries: nil,
            series: nil,
            comics: nil
        ),
        Domain.Character(
            identifier: "2",
            popularity: 2,
            name: "Batman",
            thumbnail: nil,
            description: nil,
            realName: nil,
            aliases: nil,
            birth: nil,
            mainSeries: nil,
            series: nil,
            comics: nil
        ),
        Domain.Character(
            identifier: "3",
            popularity: 3,
            name: "Spider-Man",
            thumbnail: nil,
            description: nil,
            realName: nil,
            aliases: nil,
            birth: nil,
            mainSeries: nil,
            series: nil,
            comics: nil
        )
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

    static let character = Comics_Info__Development_.Character.make(
        identifier: "1",
        popularity: 1,
        name: "Flash"
    )

    static let domainCharacter = Domain.Character(
        identifier: "1",
        popularity: 1,
        name: "Flash",
        thumbnail: nil,
        description: nil,
        realName: nil,
        aliases: nil,
        birth: nil,
        mainSeries: nil,
        series: nil,
        comics: nil
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
