//
//  SeriesDataRepository.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class SeriesDataRepository: SeriesRepository {

    var seriesDataProvider: SeriesDataProvider

    init(seriesDataProvider: SeriesDataProvider) {
        self.seriesDataProvider = seriesDataProvider
    }
    
    func getAllSeries(
        for characterID: String,
        afterID: String?,
        limit: Int,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[SeriesSummary], Error>) -> Void
    ) {
        seriesDataProvider.getAllSeries(
            for: characterID,
            afterID: afterID,
            limit: limit,
            fromDataSource: dataSource,
            onComplete: complete
        )
    }

    func getSeries(
        withID seriesID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Series, Error>) -> Void
    ) {
        seriesDataProvider.getSeries(
            withID: seriesID,
            fromDataSource: dataSource,
            onComplete: complete
        )
    }

}
