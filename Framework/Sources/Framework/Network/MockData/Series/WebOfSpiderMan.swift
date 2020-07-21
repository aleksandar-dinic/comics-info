//
//  WebOfSpiderMan.swift
//  Framework
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct WebOfSpiderMan: MockSeries {

    let identifier = "3"
    let charactersID: Set<String> = ["1"]
    private let popularity = 2
    private let title = "Web of Spider-Man"
    private let description = """
        Web of Spider-Man is the name of two different monthly comic book series starring Spider-Man \
        that have been published by Marvel Comics since 1985, the first volume of which ran for 129 \
        issues between 1985 and 1995, and the second of which ran for 12 issues between 2009 and 2010.
        """
    private let thumbnail = "WebOfSpiderMan"
    private let startYear = 1985
    private let endYear = 2012

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
