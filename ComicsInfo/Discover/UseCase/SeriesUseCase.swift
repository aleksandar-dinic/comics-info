//
//  SeriesUseCase.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class SeriesUseCase: SeriesRepositoryFactory {

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
        for characterID: String,
        afterID: String?,
        limit: Int,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[SeriesSummary], Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.getAllSeries(for: characterID, afterID: afterID, limit: limit, fromDataSource: dataSource) { result in
                DispatchQueue.main.async {
                    complete(result)
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
                    complete(result)
                }
            }
        }
    }

}
