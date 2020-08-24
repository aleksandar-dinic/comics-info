//
//  SeriesUseCaseAdapter.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol UseCases.SeriesUseCaseFactory
import enum CIData.DataSourceLayer
import protocol CIData.SeriesAPIService
import protocol CIData.SeriesCacheService
import protocol CIData.SeriesDecoderService
import Foundation

struct SeriesUseCaseAdapter: UseCases.SeriesUseCaseFactory {

    private lazy var useCase = makeSeriesUseCase()

    let seriesAPIService: SeriesAPIService
    let seriesCacheService: SeriesCacheService
    let seriesDecoderService: SeriesDecoderService

    init(
        seriesAPIService: SeriesAPIService = SeriesAPIProvider(),
        seriesCacheService: SeriesCacheService = SeriesCacheProvider(),
        seriesDecoderService: SeriesDecoderService = SeriesDecoderProvider()
    ) {
        self.seriesAPIService = seriesAPIService
        self.seriesCacheService = seriesCacheService
        self.seriesDecoderService = seriesDecoderService
    }

    mutating func getAllSeries(
        forCharacterID characterID: String,
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<[Series], Error>) -> Void
    ) {
        getAllSeries(forCharacters: [characterID], fromDataSource: dataSource, onComplete: complete)
    }

    mutating func getAllSeries(
        forCharacters characters: [String],
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<[Series], Error>) -> Void
    ) {
        useCase.getAllSeries(
            forCharacters: characters,
            fromDataSource: dataSource
        ) { result in
            complete(result.map { $0.map { Series(from: $0) } })
        }
    }

}
