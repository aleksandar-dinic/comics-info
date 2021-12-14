//
//  SeriesRepository.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol SeriesRepository {

    var seriesDataProvider: SeriesDataProvider { get }

    init(seriesDataProvider: SeriesDataProvider)
    
    func getAllSeries(
        for characterID: String,
        afterID: String?,
        limit: Int,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[SeriesSummary], Error>) -> Void
    )

    func getSeries(
        withID seriesID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Series, Error>) -> Void
    )
    
    func addInMySeries(_ seriesSeries: SeriesSummary, forCharacterID characterID: String)
    func getMySeries(for characterID: String) -> [SeriesSummary]?
    func isInMySeries(_ seriesID: String, forCharacterID characterID: String) -> Bool

}
