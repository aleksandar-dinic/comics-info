//
//  SeriesDataProviderFactory.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol SeriesDataProviderFactory: SeriesAPIWrapperFactory {

    var seriesCacheService: SeriesCacheService { get }

    func makeSeriesDataProvider() -> SeriesDataProvider

}

extension SeriesDataProviderFactory {

    func makeSeriesDataProvider() -> SeriesDataProvider {
        SeriesDataProvider(
            seriesAPIWrapper: makeSeriesAPIWrapper(),
            seriesCacheService: seriesCacheService
        )
    }

}
