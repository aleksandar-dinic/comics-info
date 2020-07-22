//
//  AmazingSpiderMan5.swift
//  Framework
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct AmazingSpiderMan5: MockComic {

    let identifier = "5"
    let seriesID: Set<String> = ["1"]
    let charactersID: Set<String> = ["1"]
    private let popularity = 0
    private let title = "Marked for Destruction by Dr. Doom!"
    private let description = """
        After a report by J. Jonah Jameson about the "menace" of Spider-Man, Peter (in order to avoid \
        any suspicion that he's really Spider-Man) speaks negatively about his alter ego, earning him \
        harsh words from Flash Thompson. Meanwhile, Dr. Doom had seen this same report, and decided that \
        after surviving his last encounter battling the Fantastic Four, that perhaps Spider-Man would make \
        for a good partner to eliminate his mortal foes.
        """
    private let thumbnail = "AmazingSpiderMan5"

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
        "seriesID": ["1"], \
        "charactersID": ["1"] \
        }
        """
    }

}
