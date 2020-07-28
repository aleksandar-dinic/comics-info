//
//  AmazingSpiderMan2.swift
//  Framework
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct AmazingSpiderMan2: MockComic {

    let identifier = "2"
    let seriesID: Set<String> = ["1"]
    let charactersID: Set<String> = ["1"]
    private let popularity = 0
    private let title = "Duel to the Death with the Vulture!"
    private let description = """
        New York City is being terrorized by a new criminal called the Vulture. He is equipped with \
        artificial wings that allow him to swoop down on his victims, snatch their valuables, and fly \
        away before they know what is happening. Nobody has been able to photograph him, and J. Jonah \
        Jameson needs pictures to illustrate his Vulture feature article for NOW Magazine. Peter Parker \
        decides to try to photograph the criminal in action. Selling the photographs will help him and \
        his Aunt May make ends meet.
        """
    private let thumbnail = "AmazingSpiderMan2"
    private let issueNumber = "2"
    private let published = Date()

    var data: Data? {
        json.data(using: .utf8)
    }

    var json: String {
        """
        { \
        "identifier": "\(identifier)", \
        "popularity": \(popularity), \
        "title": "\(title)", \
        "issueNumber": "\(issueNumber)", \
        "description": "\(description)", \
        "thumbnail": "\(thumbnail)", \
        "seriesID": ["1"], \
        "charactersID": ["1"], \
        "published": \(published.timeIntervalSince1970) \
        }
        """
    }

}
