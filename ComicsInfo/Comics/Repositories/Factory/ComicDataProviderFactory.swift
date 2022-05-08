//
//  ComicDataProviderFactory.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol ComicDataProviderFactory: ComicAPIWrapperFactory {

    var comicCacheService: ComicCacheService { get }

    func makeComicDataProvider() -> ComicDataProvider

}

extension ComicDataProviderFactory {

    func makeComicDataProvider() -> ComicDataProvider {
        ComicDataProvider(
            comicAPIWrapper: makeComicAPIWrapper(),
            comicCacheService: comicCacheService
        )
    }

}
