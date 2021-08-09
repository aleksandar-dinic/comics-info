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
    
    /// Gets all series
    ///
    /// - Parameters:
    ///   - dataSource: Layer of data source
    ///   - complete: Result who contains list of Series in Success, or Error in Failure.
    func getAllSeries(
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Series], Error>) -> Void
    )

    /// Gets series
    ///
    /// - Parameters:
    ///   - seriesID: Series ID.
    ///   - dataSource: Layer of data source
    ///   - complete: Result who contains Series in Success, or Error in Failure.
    func getSeries(
        withID seriesID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Series, Error>) -> Void
    )

}
