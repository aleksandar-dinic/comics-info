//
//  SeriesCacheProvider.swift
//  Framework
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
import protocol CIData.SeriesCacheService
import Foundation

public struct SeriesCacheProvider: CIData.SeriesCacheService {

    private let inMemoryCache: InMemoryCache<String, Domain.Series>

    init(_ inMemoryCache: InMemoryCache<String, Domain.Series> = InMemoryCache()) {
        self.inMemoryCache = inMemoryCache
    }

    public func getAllSeries(forCharacterID characterID: String) -> [Domain.Series]? {
        let cache = inMemoryCache.values.filter { $0.charactersID.contains(characterID)}
        return cache.isEmpty ? nil : cache
    }

    public func getSeries(withID seriesID: String) -> Domain.Series? {
        inMemoryCache[seriesID]
    }

    public func save(series: [Domain.Series]) {
        series.forEach {
            inMemoryCache[$0.identifier] = $0
        }
    }

}
