//
//  SeriesRepository.swift
//  CIData
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
import Foundation

public protocol SeriesRepository {

    var seriesDataProvider: SeriesDataProvider { get }

    init(seriesDataProvider: SeriesDataProvider)

    /// Gets all series
    ///
    /// - Parameters:
    ///   - characterID: Character ID
    ///   - dataSource: Layer of data source
    ///   - complete: Result who contains Series in Success, or Error in Failure.
    func getAllSeries(
        forCharacterID characterID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Domain.Series], Error>) -> Void
    )

}
