//
//  SeriesDataProviderMockFactory.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import Comics_Info__Development_
import Foundation

struct SeriesDataProviderMockFactory {

    static func makeWithSeriesFromNetwork() -> SeriesDataProvider {
        let seriesAPIWrapper = SeriesAPIWrapperMockFactory.makeWithSeries()
        let seriesCacheService = SeriesCacheServiceMock()

        return SeriesDataProvider(
            seriesAPIWrapper: seriesAPIWrapper,
            seriesCacheService: seriesCacheService
        )
    }

    static func makeWithSeriesFromMemory() -> SeriesDataProvider {
        let seriesAPIWrapper = SeriesAPIWrapperMockFactory.makeWithoutData()
        let seriesCacheService = SeriesCacheServiceMock()
        seriesCacheService.setSeries(SeriesMock.series)

        return SeriesDataProvider(
            seriesAPIWrapper: seriesAPIWrapper,
            seriesCacheService: seriesCacheService
        )
    }

    static func makeWithoutData() -> SeriesDataProvider {
        let seriesAPIWrapper = SeriesAPIWrapperMockFactory.makeWithoutData()
        let seriesCacheService = SeriesCacheServiceMock()

        return SeriesDataProvider(
            seriesAPIWrapper: seriesAPIWrapper,
            seriesCacheService: seriesCacheService
        )
    }

}
