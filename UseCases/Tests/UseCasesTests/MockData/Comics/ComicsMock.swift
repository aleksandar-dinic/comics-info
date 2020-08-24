//
//  ComicsMock.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct Domain.Comic
import Foundation

struct ComicsMock {

    static let domainComics = [
        Domain.Comic(
            identifier: "1", popularity: 1, title: "Spider-Man", thumbnail: nil,
            issueNumber: nil, description: nil, variantDescription: nil, format: nil,
            pageCount: nil, variantsIdentifier: nil, collectionsIdentifier: nil,
            collectedIssuesIdentifier: nil, images: nil, seriesID: ["1"], charactersID: ["1"], published: nil),
        Domain.Comic(
            identifier: "2", popularity: 2, title: "Duel to the Death with the Vulture!", thumbnail: nil,
            issueNumber: nil, description: nil, variantDescription: nil, format: nil,
            pageCount: nil, variantsIdentifier: nil, collectionsIdentifier: nil,
            collectedIssuesIdentifier: nil, images: nil, seriesID: ["2"], charactersID: ["1"], published: nil),
        Domain.Comic(
            identifier: "3", popularity: 3, title: "Spider-Man Versus Doctor Octopus", thumbnail: nil,
            issueNumber: nil, description: nil, variantDescription: nil, format: nil,
            pageCount: nil, variantsIdentifier: nil, collectionsIdentifier: nil,
            collectedIssuesIdentifier: nil, images: nil, seriesID: ["3"], charactersID: ["1"], published: nil)
    ]

    static let comics = """
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

}
