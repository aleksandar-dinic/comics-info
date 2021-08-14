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

    // TODO: - Get comics for seriesID
    func getAllComics(for seriesID: String) -> [ComicSummary]? {
        inMemoryCacheSumaries[seriesID]
    }

    func getComic(withID comicID: String) -> Comic? {
        inMemoryCache[comicID]
    }

    func save(comics: [Comic]) {
        for comic in comics {
            inMemoryCache[comic.identifier] = comic
        }
    }
    
    func save(comicSummaries: [String: [ComicSummary]]) {
        for (_, el) in comicSummaries.enumerated() {
            inMemoryCacheSumaries[el.key] = el.value
        }
    }

}
