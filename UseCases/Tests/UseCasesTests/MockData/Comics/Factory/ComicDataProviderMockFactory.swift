//
//  ComicDataProviderMockFactory.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import CIData
import Foundation

struct ComicDataProviderMockFactory {

    static func makeWithComics() -> ComicDataProvider {
        let comicAPIWrapper = ComicAPIWrapperMockFactory.makeWithComics()
        let comicCacheService = ComicCacheServiceMock()

        return ComicDataProvider(
            comicAPIWrapper: comicAPIWrapper,
            comicCacheService: comicCacheService
        )
    }

}
