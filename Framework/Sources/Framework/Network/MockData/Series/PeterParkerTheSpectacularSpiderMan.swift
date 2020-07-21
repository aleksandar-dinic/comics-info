//
//  PeterParkerTheSpectacularSpiderMan.swift
//  Framework
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct PeterParkerTheSpectacularSpiderMan: MockSeries {

    let identifier = "2"
    let charactersID: Set<String> = ["1"]
    private let popularity = 1
    private let title = "Peter Parker, The Spectacular Spider-Man"
    private let description = """
        The Spectacular Spider-Man is a comic book and magazine series starring Spider-Man and published \
        by Marvel Comics.
        """
    private let thumbnail = "PeterParkerTheSpectacularSpiderMan"
    private let startYear = 1976
    private let endYear = 1987

    var data: Data? {
        json.data(using: .utf8)
    }

    var json: String {
        """
        { \
        "identifier": "\(identifier)", \
        "popularity": \(popularity), \
        "title": "\(title)", \
        "description": "\(description)", \
        "thumbnail": "\(thumbnail)", \
        "startYear": \(startYear), \
        "endYear": \(endYear), \
        "charactersID": ["1"] \
        }
        """
    }

}
