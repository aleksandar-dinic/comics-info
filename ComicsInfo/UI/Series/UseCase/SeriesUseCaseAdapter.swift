//
//  SeriesUseCaseAdapter.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import enum CIData.DataSourceLayer
import protocol CIData.SeriesAPIService
import protocol CIData.SeriesCacheService
import protocol UseCases.SeriesUseCaseFactory
import Foundation

struct SeriesUseCaseAdapter: UseCases.SeriesUseCaseFactory {

    private lazy var useCase = makeSeriesUseCase()

    let seriesAPIService: SeriesAPIService
    let seriesCacheService: SeriesCacheService

    init(
        seriesAPIService: SeriesAPIService = SeriesAPIProvider(),
        seriesCacheService: SeriesCacheService = SeriesCacheProvider()
    ) {
        self.seriesAPIService = seriesAPIService
        self.seriesCacheService = seriesCacheService
    }

    mutating func getAllSeries(
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<[Series], Error>) -> Void
    ) {
        useCase.getAllSeries(fromDataSource: dataSource) { result in
            complete(result.map { $0.map { Series(from: $0) } })
        }
    }

    mutating func getSeries(
        withID seriesID: String,
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<Series, Error>) -> Void
    ) {
        useCase.getSeries(withID: seriesID, fromDataSource: dataSource) { result in
            complete(result.map { Series(from: $0) })
        }
    }

}
