//
//  SeriesRepository.swift
//  CIData
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol SeriesRepository {

    var seriesDataProvider: SeriesDataProvider { get }

    init(seriesDataProvider: SeriesDataProvider)

    /// Gets all series
    ///
    /// - Parameters:
    ///   - characters: List of characters
    ///   - dataSource: Layer of data source
    ///   - complete: Result who contains Series in Success, or Error in Failure.
    func getAllSeries(
        forCharacters characters: [String],
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Series], Error>) -> Void
    )

}
