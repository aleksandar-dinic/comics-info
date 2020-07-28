//
//  AmazingSpiderMan1.swift
//  Framework
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct AmazingSpiderMan1: MockComic {

    let identifier = "1"
    let seriesID: Set<String> = ["1"]
    let charactersID: Set<String> = ["1"]
    private let popularity = 0
    private let title = "Spider-Man"
    private let description = """
        With the Parker household desperate for money following the death of Ben Parker, Peter Parker \
        decides to continue in show business as Spider-Man. However, not only does he find it impossible \
        to cash his paycheck (made out to Spider-Man), but the irrational editorials by J. Jonah Jameson \
        in the Daily Bugle effectively quelch his career. Besides denouncing Spider-Man as a \
        publicity-seeking phony, J. Jonah Jameson also publishes articles lauding his son, John Jameson, \
        a courageous astronaut about to be launched into orbit in a space capsule. J. Jonah Jameson calls \
        his son a real hero.
        """
    private let thumbnail = "AmazingSpiderMan1"
    private let issueNumber = "1"
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
