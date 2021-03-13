//
//  ComicMock.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct Domain.Comic
@testable import struct ComicsInfo.Comic
import Foundation

struct ComicMock {

    static let comicsInfoComics = [
        ComicsInfo.Comic.make(identifier: "1", popularity: 1, title: "Spider-Man"),
        ComicsInfo.Comic.make(identifier: "2", popularity: 2, title: "Duel to the Death with the Vulture!"),
        ComicsInfo.Comic.make(identifier: "3", popularity: 3, title: "Spider-Man Versus Doctor Octopus")
    ]

    static let domainComics = [
        Domain.Comic(
            identifier: "1", popularity: 1, title: "Spider-Man", thumbnail: nil,
            description: nil, number: nil, aliases: nil, variantDescription: nil,
            format: nil, pageCount: nil, variantsIdentifier: nil, collectionsIdentifier: nil,
            collectedIdentifiers: nil, images: nil, published: nil, characters: nil,
            series: nil
        ),
        Domain.Comic(
            identifier: "2", popularity: 2, title: "Duel to the Death with the Vulture!", thumbnail: nil,
            description: nil, number: nil, aliases: nil, variantDescription: nil,
            format: nil, pageCount: nil, variantsIdentifier: nil, collectionsIdentifier: nil,
            collectedIdentifiers: nil, images: nil, published: nil, characters: nil,
            series: nil),
        Domain.Comic(
            identifier: "3", popularity: 3, title: "Spider-Man Versus Doctor Octopus", thumbnail: nil,
            description: nil, number: nil, aliases: nil, variantDescription: nil,
            format: nil, pageCount: nil, variantsIdentifier: nil, collectionsIdentifier: nil,
            collectedIdentifiers: nil, images: nil, published: nil, characters: nil,
            series: nil)
    ]

    static let comicsData = """
        [
            {
                "identifier": "1",
                "popularity": 1,
                "title": "Spider-Man",
                "seriesID": ["1"],
                "charactersID": ["1"]
            },{
                "identifier": "2",
                "popularity": 2,
                "title": "Duel to the Death with the Vulture!",
                "seriesID": ["2"],
                "charactersID": ["1"]
            },{
                "identifier": "3",
                "popularity": 3,
                "title": "Spider-Man Versus Doctor Octopus",
                "seriesID": ["3"],
                "charactersID": ["1"]
            }
        ]
    """.data(using: .utf8)

    static let comicBadData = """
        [
            {
                "identifier": "1",
                "popularity": 1,,
                "seriesID": ["1"],
                "charactersID": ["1"]
            },{
                "identifier": "2",
                "popularity": 2,
                "title": "Duel to the Death with the Vulture!",
                "seriesID": ["2"],
                "charactersID": ["1"]
            },{
                "identifier": "3",
                "popularity": 3,
                "title": "Spider-Man Versus Doctor Octopus",
                "seriesID": ["3"],
                "charactersID": ["1"]
            }
        ]
    """.data(using: .utf8)

}
