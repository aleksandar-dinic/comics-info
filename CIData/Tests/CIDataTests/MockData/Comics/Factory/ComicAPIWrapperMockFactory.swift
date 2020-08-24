//
//  ComicAPIWrapperMockFactory.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import CIData
import Foundation

struct ComicAPIWrapperMockFactory {

    static func makeWithComics() -> ComicAPIWrapper {
        let comicAPIServiceMock = ComicAPIServiceMock(ComicMock.comicsData)
        let comicDecoderMock = ComicDecoderMock(ComicMock.domainComics)

        return ComicAPIWrapper(
            comicAPIService: comicAPIServiceMock,
            comicDecoderService: comicDecoderMock
        )
    }

    static func makeWithoutData() -> ComicAPIWrapper {
        let comicAPIServiceMock = ComicAPIServiceMock()
        let comicDecoderMock = ComicDecoderMock()

        return ComicAPIWrapper(
            comicAPIService: comicAPIServiceMock,
            comicDecoderService: comicDecoderMock
        )
    }

    static func makeWithComicBadData() -> ComicAPIWrapper {
        let comicAPIServiceMock = ComicAPIServiceMock(ComicMock.comicBadData)
        let comicDecoderMock = ComicDecoderMock()

        return ComicAPIWrapper(
            comicAPIService: comicAPIServiceMock,
            comicDecoderService: comicDecoderMock
        )
    }

}
