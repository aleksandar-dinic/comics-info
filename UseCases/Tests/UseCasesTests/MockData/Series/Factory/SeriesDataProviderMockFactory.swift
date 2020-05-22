//
//  SeriesDataProviderMockFactory.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 22/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import CIData
import Foundation

struct SeriesDataProviderMockFactory {

    static func makeWithSeries() -> SeriesDataProvider {
        let seriesAPIWrapper = SeriesAPIWrapperMockFactory.makeWithSeries()
        let seriesCacheService = SeriesCacheServiceMock()

        return SeriesDataProvider(
            seriesAPIWrapper: seriesAPIWrapper,
            seriesCacheService: seriesCacheService
        )
    }

}
