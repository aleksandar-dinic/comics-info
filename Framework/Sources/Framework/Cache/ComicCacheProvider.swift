//
//  ComicCacheProvider.swift
//  Framework
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
import protocol CIData.ComicCacheService
import Foundation

public struct ComicCacheProvider: CIData.ComicCacheService {

    private let inMemoryCache: InMemoryCache<String, Domain.Comic>

    init(_ inMemoryCache: InMemoryCache<String, Domain.Comic> = InMemoryCache()) {
        self.inMemoryCache = inMemoryCache
    }

    public func getAllComics(forSeriesID seriesID: String) -> [Domain.Comic]? {
        let cache = inMemoryCache.values.filter { $0.seriesID.contains(seriesID)}
        return cache.isEmpty ? nil : cache
    }

    public func getComic(withID comicID: String) -> Domain.Comic? {
        inMemoryCache[comicID]
    }

    public func save(comics: [Domain.Comic]) {
        for comic in comics {
            inMemoryCache[comic.identifier] = comic
        }
    }

}
