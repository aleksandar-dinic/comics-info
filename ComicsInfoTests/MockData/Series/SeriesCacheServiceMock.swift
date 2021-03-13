//
//  SeriesCacheServiceMock.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct ComicsInfo.Series
@testable import protocol ComicsInfo.SeriesCacheService
import Foundation

final class SeriesCacheServiceMock: SeriesCacheService {

    private var series: [String: Series]

    init(_ series: [String: Series] = [:]) {
        self.series = series
    }

    func getAllSeries() -> [Series]? {
        series.values.isEmpty ? nil : Array(series.values)
    }

    func getSeries(withID seriesID: String) -> Series? {
        series[seriesID]
    }

    func save(series: [Series]) {
        for ser in series {
            self.series[ser.identifier] = ser
        }
    }

}

extension SeriesCacheServiceMock {

    func setSeries(_ series: [Series]) {
        series.forEach {
            self.series[$0.identifier] = $0
        }
    }

}
