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

    init(_ inMemoryCache: InMemoryCache<String, Comic> = InMemoryCache()) {
        self.inMemoryCache = inMemoryCache
    }

    func getAllComics() -> [Comic]? {
        !inMemoryCache.isEmpty ? inMemoryCache.values : nil
    }

    func getComic(withID comicID: String) -> Comic? {
        inMemoryCache[comicID]
    }

    func save(comics: [Comic]) {
        for comic in comics {
            inMemoryCache[comic.identifier] = comic
        }
    }

}
