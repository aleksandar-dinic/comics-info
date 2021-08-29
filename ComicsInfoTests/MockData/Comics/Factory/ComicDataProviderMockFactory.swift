//
//  ComicDataProviderMockFactory.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfo__Development_
import Foundation

struct ComicDataProviderMockFactory {

    static func makeWithComicFromNetwork() -> ComicDataProvider {
        let comicAPIWrapper = ComicAPIWrapperMockFactory.makeWithComics()
        let comicCacheService = ComicCacheServiceMock()

        return ComicDataProvider(
            comicAPIWrapper: comicAPIWrapper,
            comicCacheService: comicCacheService
        )
    }

    static func makeWithComicFromMemory() -> ComicDataProvider {
        let comicAPIWrapper = ComicAPIWrapperMockFactory.makeWithoutData()
        let comicCacheService = ComicCacheServiceMock()
        comicCacheService.setComics(ComicMock.comicsInfoComics)

        return ComicDataProvider(
            comicAPIWrapper: comicAPIWrapper,
            comicCacheService: comicCacheService
        )
    }

    static func makeWithoutData() -> ComicDataProvider {
        let comicAPIWrapper = ComicAPIWrapperMockFactory.makeWithoutData()
        let comicCacheService = ComicCacheServiceMock()

        return ComicDataProvider(
            comicAPIWrapper: comicAPIWrapper,
            comicCacheService: comicCacheService
        )
    }

}
