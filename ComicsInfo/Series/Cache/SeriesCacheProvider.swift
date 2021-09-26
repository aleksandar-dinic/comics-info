//
//  SeriesCacheProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI
import Foundation

struct SeriesCacheProvider: SeriesCacheService {

    private let seriesCache: Cache<String, Series>
    private let seriesSumariesCache: Cache<String, [SeriesSummary]>

    init(
        seriesCache: Cache<String, Series> = SwiftUI.Environment(\.seriesCache).wrappedValue,
        seriesSumariesCache: Cache<String, [SeriesSummary]> = SwiftUI.Environment(\.seriesSummariesCache).wrappedValue
    ) {
        self.seriesCache = seriesCache
        self.seriesSumariesCache = seriesSumariesCache
    }

    func getAllSeries(
        for characterID: String,
        afterID: String?,
        limit: Int
    ) -> [SeriesSummary]? {
        guard var items = seriesSumariesCache[characterID], !items.isEmpty else { return nil }
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

    func save(seriesSummaries: [SeriesSummary], forCharacterID characterID: String) {
        var value = [SeriesSummary]()
        var keys = Set<String>()
        if let oldValue = seriesSumariesCache[characterID] {
            value = oldValue
            oldValue
                .map { $0.identifier }
                .forEach { keys.insert($0) }
        }
        
        for summary in seriesSummaries where !keys.contains(summary.identifier) {
            value.append(summary)
        }
        seriesSumariesCache[characterID] = value
        try? seriesSumariesCache.saveToDisc(.seriesSummaries)
    }
    
    func getSeries(withID seriesID: String) -> Series? {
        seriesCache[seriesID]
    }

    func save(series: Series) {
        seriesCache[series.identifier] = series
        try? seriesCache.saveToDisc(.series)
    }

}
