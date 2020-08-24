//
//  SeriesCacheProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct CIData.Series
import protocol CIData.SeriesCacheService
import Foundation

public struct SeriesCacheProvider: CIData.SeriesCacheService {

    private let inMemoryCache: InMemoryCache<String, Series>

    init(_ inMemoryCache: InMemoryCache<String, Series> = InMemoryCache()) {
        self.inMemoryCache = inMemoryCache
    }

    public func getAllSeries(forCharacters characters: [String]) -> [CIData.Series]? {
        var cache = Set<Series>()
        for character in characters {
            for series in inMemoryCache.values.filter({ $0.charactersID.contains(character) }) {
                cache.insert(series)
            }
        }
        return cache.isEmpty ? nil : Array(cache.map({ CIData.Series(from: $0) }))
    }

    public func getSeries(withID seriesID: String) -> CIData.Series? {
        guard let series = inMemoryCache[seriesID] else {
            return nil
        }
        return CIData.Series(from: series)
    }

    public func save(series: [CIData.Series]) {
        series.forEach {
            inMemoryCache[$0.identifier] = Series(from: $0)
        }
    }

}
