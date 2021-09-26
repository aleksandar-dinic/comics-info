//
//  SeriesMock.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct Domain.Series
@testable import struct ComicsInfo__Development_.Series
import Foundation

struct SeriesMock {
    
    static let series1 = ComicsInfo__Development_.Series(
        identifier: "1",
        popularity: 0,
        title: "Title",
        thumbnail: nil,
        description: nil,
        startYear: nil,
        endYear: nil,
        aliases: nil,
        characters: nil,
        comics: nil
    )

    static let series2 = ComicsInfo__Development_.Series(
        identifier: "2",
        popularity: 0,
        title: "Title",
        thumbnail: nil,
        description: nil,
        startYear: nil,
        endYear: nil,
        aliases: nil,
        characters: nil,
        comics: nil
    )

    static let series = [
        ComicsInfo__Development_.Series.make(identifier: "1", popularity: 1, title: "The Flash Vol 2"),
        ComicsInfo__Development_.Series.make(identifier: "2", popularity: 2, title: "Batman and Robin"),
        ComicsInfo__Development_.Series.make(identifier: "3", popularity: 3, title: "Spider-Man")
    ]

    static let domainSeries = [
        Domain.Series(
            identifier: "1",
            popularity: 1,
            title: "The Flash Vol 2",
            thumbnail: nil,
            description: nil,
            startYear: nil,
            endYear: nil,
            aliases: nil,
            nextIdentifier: nil,
            characters: nil,
            comics: nil
        ),
        Domain.Series(
            identifier: "2",
            popularity: 2,
            title: "Batman and Robin",
            thumbnail: nil,
            description: nil,
            startYear: nil,
            endYear: nil,
            aliases: nil,
            nextIdentifier: nil,
            characters: nil,
            comics: nil
        ),
        Domain.Series(
            identifier: "3",
            popularity: 3,
            title: "Spider-Man",
            thumbnail: nil,
            description: nil,
            startYear: nil,
            endYear: nil,
            aliases: nil,
            nextIdentifier: nil,
            characters: nil,
            comics: nil
        )
    ]

    static let seriesData = """
        [
            {
                "identifier": "1",
                "popularity": 1,
                "title": "The Flash Vol 2",
                "charactersID": ["1"]
            },{
                "identifier": "2",
                "popularity": 2,
                "title": "Batman and Robin",
                "charactersID": ["2"]
            },{
                "identifier": "3",
                "popularity": 3,
                "title": "Spider-Man",
                "charactersID": ["3"]
            }
        ]
    """.data(using: .utf8)

    static let seriesBadData = """
        [
            {
                "identifier": "1",
                "popularity": 1,,
                "charactersID": ["1"]
            },{
                "identifier": "2",
                "popularity": 2,
                "title": "Batman and Robin",
                "charactersID": ["2"]
            },{
                "identifier": "3",
                "popularity": 3,
                "title": "Spider-Man",
                "charactersID": ["3"]
            }
        ]
    """.data(using: .utf8)

}
