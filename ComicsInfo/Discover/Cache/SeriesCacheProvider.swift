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
    private let inMemoryCacheSumaries: InMemoryCache<String, [SeriesSummary]>

    init(
        inMemoryCache: InMemoryCache<String, Series> = InMemoryCache(),
        inMemoryCacheSumaries: InMemoryCache<String, [SeriesSummary]> = InMemoryCache()
    ) {
        self.inMemoryCache = inMemoryCache
        self.inMemoryCacheSumaries = inMemoryCacheSumaries
    }

    func getAllSeries(
        for characterID: String,
        afterID: String?,
        limit: Int
    ) -> [SeriesSummary]? {
        guard var items = inMemoryCacheSumaries[characterID], !items.isEmpty else { return nil }
        var start = 0
        let count = items.count

        if let afterID = afterID {
            guard let firstIndex = items.firstIndex(where: { $0.identifier == afterID }) else {
                return nil
            }
            start = firstIndex + 1
        }

        items = Array(items[start..<min(count, start+limit)])
        return !items.isEmpty ? items : nil
    }

    func getSeries(withID seriesID: String) -> Series? {
        inMemoryCache[seriesID]
    }

    func save(series: [Series]) {
        series.forEach {
            inMemoryCache[$0.identifier] = $0
        }
    }
    
    func save(seriesSummaries: [SeriesSummary], forCharacterID characterID: String) {
        var value = [SeriesSummary]()
        var keys = Set<String>()
        if let oldValue = inMemoryCacheSumaries[characterID] {
            value = oldValue
            oldValue
                .map { $0.identifier }
                .forEach { keys.insert($0) }
        }
        
        for summary in seriesSummaries where !keys.contains(summary.identifier) {
            value.append(summary)
        }
        inMemoryCacheSumaries[characterID] = value
    }

}
