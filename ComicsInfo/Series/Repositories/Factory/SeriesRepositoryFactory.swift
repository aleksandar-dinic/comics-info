//
//  SeriesRepositoryFactory.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol SeriesRepositoryFactory: SeriesDataProviderFactory {

    func makeSeriesRepository() -> SeriesRepository

}

extension SeriesRepositoryFactory {

    func makeSeriesRepository() -> SeriesRepository {
        SeriesDataRepository(seriesDataProvider: makeSeriesDataProvider())
    }

}
