//
//  SeriesAPIWrapperMockFactory.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import Comics_Info__Development_
import Foundation

struct SeriesAPIWrapperMockFactory {

    static func makeWithSeries() -> SeriesAPIWrapper {
        let seriesAPIServiceMock = SeriesAPIServiceMock(SeriesMock.seriesData)

        return SeriesAPIWrapper(seriesAPIService: seriesAPIServiceMock)
    }

    static func makeWithoutData() -> SeriesAPIWrapper {
        let seriesAPIServiceMock = SeriesAPIServiceMock()

        return SeriesAPIWrapper(seriesAPIService: seriesAPIServiceMock)
    }

    static func makeWithSeriesBadData() -> SeriesAPIWrapper {
        let seriesAPIServiceMock = SeriesAPIServiceMock(SeriesMock.seriesBadData)

        return SeriesAPIWrapper(seriesAPIService: seriesAPIServiceMock)
    }

}
