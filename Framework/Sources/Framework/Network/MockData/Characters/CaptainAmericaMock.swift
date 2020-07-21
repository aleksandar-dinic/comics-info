//
//  CaptainAmericaMock.swift
//  Framework
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct CaptainAmericaMock: MockData {

    let identifier = "2"
    private let popularity = 1
    private let name = "Captain America"
    private let description = """
        Vowing to serve his country any way he could, young Steve Rogers took the super soldier \
        serum to become America's one-man army. Fighting for the red, white and blue for over 60 years, Captain \
        America is the living, breathing symbol of freedom and liberty.
        """
    private let thumbnail = "CaptainAmerica"

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
