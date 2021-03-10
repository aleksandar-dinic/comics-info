//
//  ComicCacheProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct CIData.Comic
import protocol CIData.ComicCacheService
import Foundation

public struct ComicCacheProvider: CIData.ComicCacheService {

    private let inMemoryCache: InMemoryCache<String, Comic>

    init(_ inMemoryCache: InMemoryCache<String, Comic> = InMemoryCache()) {
        self.inMemoryCache = inMemoryCache
    }

    public func getAllComics() -> [CIData.Comic]? {
        inMemoryCache.values.map({ CIData.Comic(from: $0) })
    }

    public func getComic(withID comicID: String) -> CIData.Comic? {
        guard let comic = inMemoryCache[comicID] else {
            return nil
        }
        return CIData.Comic(from: comic)
    }

    public func save(comics: [CIData.Comic]) {
        for comic in comics {
            inMemoryCache[comic.identifier] = Comic(from: comic)
        }
    }

}
