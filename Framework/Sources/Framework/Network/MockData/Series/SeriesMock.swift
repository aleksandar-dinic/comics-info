//
//  SeriesMock.swift
//  Framework
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct SeriesMock {

    private let mockSeries: [MockData]

    init(_ mockSeries: [MockData] = [
        AmazingSpiderMan(),
        AmazingSpiderManVol5(),
        PeterParkerTheSpectacularSpiderMan(),
        WebOfSpiderMan()
        ]
    ) {
        self.mockSeries = mockSeries
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
