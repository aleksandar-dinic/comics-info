//
//  SeriesCacheServiceMock.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct CIData.Series
import protocol CIData.SeriesCacheService
import Foundation

final class SeriesCacheServiceMock: SeriesCacheService {

    private var series: [String: CIData.Series]

    init(_ series: [String: CIData.Series] = [:]) {
        self.series = series
    }

    func getAllSeries(forCharacters characters: [String]) -> [CIData.Series]? {
        var cache = [String: CIData.Series]()
        for character in characters {
            for series in series.values.filter({ $0.charactersID.contains(character) }) {
                cache[series.identifier] = series
            }
        }
        return cache.isEmpty ? nil : Array(cache.values)
    }

    func getSeries(withID seriesID: String) -> CIData.Series? {
        series[seriesID]
    }

    func save(series: [CIData.Series]) {
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
