//
//  AmazingSpiderMan.swift
//  Framework
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct AmazingSpiderMan: MockSeries {

    let identifier = "1"
    let charactersID: Set<String> = ["1"]
    private let popularity = 0
    private let title = "Amazing Spider-Man"
    private let description = """
        The Amazing Spider-Man is an American comic book series published by Marvel Comics, featuring the \
        fictional superhero Spider-Man as its main protagonist.
        """
    private let thumbnail = "AmazingSpiderMan"
    private let startYear = 1963
    private let endYear = 2018

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
