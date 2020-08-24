//
//  ComicUseCaseAdapter.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol UseCases.ComicUseCaseFactory
import enum CIData.DataSourceLayer
import protocol CIData.ComicAPIService
import protocol CIData.ComicCacheService
import protocol CIData.ComicDecoderService
import Foundation

struct ComicUseCaseAdapter: UseCases.ComicUseCaseFactory {

    private lazy var useCase = makeComicUseCase()

    let comicAPIService: ComicAPIService
    let comicCacheService: ComicCacheService
    let comicDecoderService: ComicDecoderService

    init(
        comicAPIService: ComicAPIService = ComicAPIProvider(),
        comicCacheService: ComicCacheService = ComicCacheProvider(),
        comicDecoderService: ComicDecoderService = ComicDecoderProvider()
    ) {
        self.comicAPIService = comicAPIService
        self.comicCacheService = comicCacheService
        self.comicDecoderService = comicDecoderService
    }

    mutating func getAllComics(
        forSeriesID seriesID: String,
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<[Comic], Error>) -> Void
    ) {
        useCase.getAllComics(
            forSeriesID: seriesID,
            fromDataSource: dataSource
        ) { result in
            complete(result.map { $0.map { Comic(from: $0) } })
        }
    }

}
