//
//  SeriesMock.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct Domain.Series
@testable import struct CIData.Series
import Foundation

struct SeriesMock {

    static let series = [
        CIData.Series(identifier: "1", popularity: 1, title: "The Flash Vol 2", thumbnail: nil,
                      description: nil, startYear: nil, endYear: nil, charactersID: ["1"]),
        CIData.Series(identifier: "2", popularity: 2, title: "Batman and Robin", thumbnail: nil,
                      description: nil, startYear: nil, endYear: nil, charactersID: ["2"]),
        CIData.Series(identifier: "3", popularity: 3, title: "Spider-Man", thumbnail: nil,
                      description: nil, startYear: nil, endYear: nil, charactersID: ["3"])
    ]

    static let domainSeries = [
        Domain.Series(identifier: "1", popularity: 1, title: "The Flash Vol 2", description: nil,
                      startYear: nil, endYear: nil, thumbnail: nil, charactersID: ["1"], nextIdentifier: nil),
        Domain.Series(identifier: "2", popularity: 2, title: "Batman and Robin", description: nil,
                      startYear: nil, endYear: nil, thumbnail: nil, charactersID: ["2"], nextIdentifier: nil),
        Domain.Series(identifier: "3", popularity: 3, title: "Spider-Man", description: nil,
                      startYear: nil, endYear: nil, thumbnail: nil, charactersID: ["3"], nextIdentifier: nil)
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
