//
//  SeriesUseCase.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import enum CIData.DataSourceLayer
import protocol CIData.SeriesAPIService
import protocol CIData.SeriesCacheService
import protocol CIData.SeriesRepositoryFactory
import Foundation

final class SeriesUseCase: CIData.SeriesRepositoryFactory {

    private lazy var repository = makeSeriesRepository()

    let seriesAPIService: SeriesAPIService
    let seriesCacheService: SeriesCacheService

    init(
        seriesAPIService: SeriesAPIService = SeriesAPIProvider(),
        seriesCacheService: SeriesCacheService = SeriesCacheProvider()
    ) {
        self.seriesAPIService = seriesAPIService
        self.seriesCacheService = seriesCacheService
    }
    
    func getAllSeries(
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Series], Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.getAllSeries(fromDataSource: dataSource) { result in
                DispatchQueue.main.async {
                    complete(result.map { $0.map { Series(from: $0) } })
                }
            }
        }
    }
    
    func getSeries(
        withID seriesID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Series, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.getSeries(withID: seriesID, fromDataSource: dataSource) { result in
                DispatchQueue.main.async {
                    complete(result.map { Series(from: $0) })
                }
            }
        }
    }

}
