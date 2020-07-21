//
//  HulkMock.swift
//  Framework
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct HulkMock: MockData {

    let identifier = "3"
    private let popularity = 2
    private let name = "Hulk"
    private let description = """
        Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce \
        Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood \
        hero, the angrier the Hulk gets, the stronger the Hulk gets.
        """
    private let thumbnail = "Hulk"

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
