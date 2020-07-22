//
//  AmazingSpiderMan4.swift
//  Framework
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct AmazingSpiderMan4: MockComic {

    let identifier = "4"
    let seriesID: Set<String> = ["1"]
    let charactersID: Set<String> = ["1"]
    private let popularity = 0
    private let title = "Nothing Can Stop... the Sandman!"
    private let description = """
        Spider-Man sees a few punks casing a jewelry store and webs them up before they can rob it. \
        However, the thugs threaten to sue Spider-Man for assault and battery! Spider-Man must flee \
        when they call the cops, since all the evidence makes him look guilty. Spider-Man blames Jameson \
        for this treatment and leaves him a little souvenir in his office. After leaving Jameson's office, \
        Spider-Man runs into the Sandman on a rooftop. Sandman gets the best of Spider-Man, and Spider-Man's \
        mask is torn in the process, so he must flee before his identity is revealed. While at home sewing up \
        his mask, Peter Parker learns the identity of the Sandman during a news bulletin. Originally an escaped \
        convict, Sandman hid on a beach at a radioactive testing facility. During one of the tests, he was \
        exposed to radioactivity, and his body gained the power to act as if it were made of sand. The bulletin \
        also shows Sandman robbing a bank and fleeing the police.
        """
    private let thumbnail = "AmazingSpiderMan4"

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
