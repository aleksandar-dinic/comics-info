//
//  ComicAPIWrapperMockFactory.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import CIData
import Foundation

struct ComicAPIWrapperMockFactory {

    static func makeWithComics() -> ComicAPIWrapper {
        let comicAPIServiceMock = ComicAPIServiceMock(ComicsMock.comics)
        let comicDecoderMock = ComicDecoderMock(ComicsMock.domainComics)

        return ComicAPIWrapper(
            comicAPIService: comicAPIServiceMock,
            comicDecoderService: comicDecoderMock
        )
    }

}
