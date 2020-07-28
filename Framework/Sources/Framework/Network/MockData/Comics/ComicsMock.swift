//
//  ComicsMock.swift
//  Framework
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct ComicsMock {

    private let mockComics: [MockComic]

    init(
        forSeriesID seriesID: String,
        _ mockComics: [MockComic] = [
            AmazingSpiderMan1(),
            AmazingSpiderMan2(),
            AmazingSpiderMan3(),
            AmazingSpiderMan4(),
            AmazingSpiderMan5()
        ]
    ) {
        self.mockComics = mockComics.filter { $0.seriesID.contains(seriesID) }
    }

    var data: Data? {
        "[\(mockComics.map { $0.json }.joined(separator: ","))]".data(using: .utf8)
    }

    var comics: [String: Data?] {
        var comics = [String: Data?]()
        for mock in mockComics {
            comics[mock.identifier] = mock.data
        }
        return comics
    }

}
