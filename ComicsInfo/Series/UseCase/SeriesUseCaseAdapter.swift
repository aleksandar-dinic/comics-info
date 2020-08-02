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
import Foundation

struct SeriesUseCaseAdapter: UseCases.SeriesUseCaseFactory {

    private lazy var useCase = makeSeriesUseCase()

    let seriesAPIService: SeriesAPIService
    let seriesCacheService: SeriesCacheService

    init(
        seriesAPIService: SeriesAPIService = SeriesAPIProviderFactory().makeSeriesAPIProvider(),
        seriesCacheService: SeriesCacheService = SeriesCacheProviderFactory().makeSeriesCacheProvider()
    ) {
        self.seriesAPIService = seriesAPIService
        self.seriesCacheService = seriesCacheService
    }

    mutating func getAllSeries(
        forCharacterID characterID: String,
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<[Series], Error>) -> Void
    ) {
        useCase.getAllSeries(
            forCharacterID: characterID,
            fromDataSource: dataSource
        ) { result in
            complete(result.map { $0.map { Series(from: $0) } })
        }
    }

}
