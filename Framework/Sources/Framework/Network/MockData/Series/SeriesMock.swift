//
//  SeriesMock.swift
//  Framework
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct SeriesMock {

    private var mockSeries: [MockSeries]

    init(
        forCharacters characters: String,
        mockSeries: [MockSeries] = [
        AmazingSpiderMan(),
        AmazingSpiderManVol5(),
        PeterParkerTheSpectacularSpiderMan(),
        WebOfSpiderMan(),
        CaptainAmericaComics()
        ]
    ) {
        self.mockSeries = [MockSeries]()

        for characterID in characters.split(separator: ",").map({ String($0) }) {
            self.mockSeries.append(contentsOf: mockSeries.filter { $0.charactersID.contains(characterID) })
        }
    }

    var data: Data? {
        "[\(mockSeries.map { $0.json }.joined(separator: ","))]".data(using: .utf8)
    }

    var series: [String: Data?] {
        var series = [String: Data?]()
        for mock in mockSeries {
            series[mock.identifier] = mock.data
        }
        return series
    }

}
