//
//  CaptainAmericaComics.swift
//  Framework
//
//  Created by Aleksandar Dinic on 09/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct CaptainAmericaComics: MockSeries {

    let identifier = "5"
    let charactersID: Set<String> = ["2"]
    private let popularity = 0
    private let title = "Captain America Comics"
    private let description = """
        During the dark days of the early 1940's, a covert U.S. Military experiment turned Steve Rogers \
        into America's first Super-Soldier, Captain America.
        """
    private let thumbnail = "CaptainAmericaComics"
    private let startYear = 1941
    private let endYear = 1949

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
        "charactersID": ["2"] \
        }
        """
    }

}
