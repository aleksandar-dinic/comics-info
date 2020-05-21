//
//  SeriesRepositoryFactory.swift
//  CIData
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol SeriesRepositoryFactory: SeriesDataProviderFactory {

    func makeSeriesRepository() -> SeriesRepository

}

extension SeriesRepositoryFactory {

    public func makeSeriesRepository() -> SeriesRepository {
        SeriesDataRepository(seriesDataProvider: makeSeriesDataProvider())
    }

}
