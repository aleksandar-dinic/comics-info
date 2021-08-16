//
//  ComicCacheProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct ComicCacheProvider: ComicCacheService {

    private let inMemoryCache: InMemoryCache<String, Comic>
    private let inMemoryCacheSumaries: InMemoryCache<String, [ComicSummary]>

    init(
        inMemoryCache: InMemoryCache<String, Comic> = InMemoryCache(),
        inMemoryCacheSumaries: InMemoryCache<String, [ComicSummary]> = InMemoryCache()
    ) {
        self.inMemoryCache = inMemoryCache
        self.inMemoryCacheSumaries = inMemoryCacheSumaries
    }

    func getComicSummaries(
        for seriesID: String,
        afterID: String?,
        limit: Int
    ) -> [ComicSummary]? {
        guard var items = inMemoryCacheSumaries[seriesID], !items.isEmpty else { return nil }
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

    func getComic(withID comicID: String) -> Comic? {
        inMemoryCache[comicID]
    }

    func save(comics: [Comic]) {
        for comic in comics {
            inMemoryCache[comic.identifier] = comic
        }
    }
    
    func save(comicSummaries: [ComicSummary], forSeriesID seriesID: String) {
        var value = [ComicSummary]()
        var keys = Set<String>()
        if let oldValue = inMemoryCacheSumaries[seriesID] {
            value = oldValue
            oldValue
                .map { $0.identifier }
                .forEach { keys.insert($0) }
        }
        
        for summary in comicSummaries where !keys.contains(summary.identifier) {
            value.append(summary)
        }
        inMemoryCacheSumaries[seriesID] = value
    }

}
