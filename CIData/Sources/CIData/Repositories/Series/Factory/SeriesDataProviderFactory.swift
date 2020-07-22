//
//  SeriesDataProviderFactory.swift
//  CIData
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol SeriesDataProviderFactory: SeriesAPIWrapperFactory {

    var seriesCacheService: SeriesCacheService { get }

    func makeSeriesDataProvider() -> SeriesDataProvider

}

extension SeriesDataProviderFactory {

    public func makeSeriesDataProvider() -> SeriesDataProvider {
        SeriesDataProvider(
            seriesAPIWrapper: makeSeriesAPIWrapper(),
            seriesCacheService: seriesCacheService
        )
    }

}
