//
//  SeriesMock.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 22/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct SeriesMock {

    static let series = """
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

}
