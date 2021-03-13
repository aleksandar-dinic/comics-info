//
//  SeriesCacheProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct SeriesCacheProvider: SeriesCacheService {

    private let inMemoryCache: InMemoryCache<String, Series>

    init(_ inMemoryCache: InMemoryCache<String, Series> = InMemoryCache()) {
        self.inMemoryCache = inMemoryCache
    }

    func getAllSeries() -> [Series]? {
        !inMemoryCache.isEmpty ? inMemoryCache.values : nil
    }

    func getSeries(withID seriesID: String) -> Series? {
        inMemoryCache[seriesID]
    }

    func save(series: [Series]) {
        series.forEach {
            inMemoryCache[$0.identifier] = $0
        }
    }

}
