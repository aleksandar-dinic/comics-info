//
//  SilverSurferMock.swift
//  Framework
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct SilverSurferMock: MockCharacter {

    let identifier = "5"
    private let popularity = 4
    private let name = "Silver Surfer"
    private let description = """
        When Zenn-La was threatened by the world-devouring entity known as Galactus, Norrin Radd \
        stood up for his home planet and offered to work for Galactus, finding him new planets to eat, in exchange \
        for saving his own. Years later, thse Surfer has protected Earth and many other planets, becoming one of the \
        greatest heroes in the universe.
        """
    private let thumbnail = "http://i.annihil.us/u/prod/marvel/i/mg/3/50/527bb6490a176.jpg"

    var data: Data? {
        json.data(using: .utf8)
    }

    var json: String {
        """
        { \
        "identifier": "\(identifier)", \
        "popularity": \(popularity), \
        "name": "\(name)", \
        "description": "\(description)", \
        "thumbnail": "\(thumbnail)" \
        }
        """
    }

}
