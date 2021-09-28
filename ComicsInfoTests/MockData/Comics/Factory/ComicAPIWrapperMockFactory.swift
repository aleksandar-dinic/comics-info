//
//  ComicAPIWrapperMockFactory.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import Comics_Info__Development_
import Foundation

struct ComicAPIWrapperMockFactory {

    static func makeWithComics() -> ComicAPIWrapper {
        let comicAPIServiceMock = ComicAPIServiceMock(ComicMock.comicsData)

        return ComicAPIWrapper(comicAPIService: comicAPIServiceMock)
    }

    static func makeWithoutData() -> ComicAPIWrapper {
        let comicAPIServiceMock = ComicAPIServiceMock()

        return ComicAPIWrapper(comicAPIService: comicAPIServiceMock)
    }

    static func makeWithComicBadData() -> ComicAPIWrapper {
        let comicAPIServiceMock = ComicAPIServiceMock(ComicMock.comicBadData)

        return ComicAPIWrapper(comicAPIService: comicAPIServiceMock)
    }

}
