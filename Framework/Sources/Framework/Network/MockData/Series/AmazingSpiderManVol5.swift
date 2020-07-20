//
//  AmazingSpiderManVol5.swift
//  Framework
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct AmazingSpiderManVol5: MockData {

    let identifier = "4"
    private let popularity = 0
    private let title = "Amazing Spider-Man Vol 5"
    private let description = """
        The Amazing Spider-Man is an American comic book series published by Marvel Comics, featuring the \
        fictional superhero Spider-Man as its main protagonist.
        """
    private let thumbnail = "AmazingSpiderManVol5"
    private let startYear = 2018
    private let charactersID = ["1"]

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
        "startYear": "\(startYear)", \
        "charactersID": \(charactersID)" \
        }
        """
    }

}
