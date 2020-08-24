//
//  SeriesAPIWrapperMockFactory.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import CIData
import Foundation

struct SeriesAPIWrapperMockFactory {

    static func makeWithSeries() -> SeriesAPIWrapper {
        let seriesAPIServiceMock = SeriesAPIServiceMock(SeriesMock.seriesData)
        let seriesDecoderMock = SeriesDecoderMock(SeriesMock.domainSeries)

        return SeriesAPIWrapper(
            seriesAPIService: seriesAPIServiceMock,
            seriesDecoderService: seriesDecoderMock
        )
    }

    static func makeWithoutData() -> SeriesAPIWrapper {
        let seriesAPIServiceMock = SeriesAPIServiceMock()
        let seriesDecoderMock = SeriesDecoderMock()

        return SeriesAPIWrapper(
            seriesAPIService: seriesAPIServiceMock,
            seriesDecoderService: seriesDecoderMock
        )
    }

    static func makeWithSeriesBadData() -> SeriesAPIWrapper {
        let seriesAPIServiceMock = SeriesAPIServiceMock(SeriesMock.seriesBadData)
        let seriesDecoderMock = SeriesDecoderMock()

        return SeriesAPIWrapper(
            seriesAPIService: seriesAPIServiceMock,
            seriesDecoderService: seriesDecoderMock
        )
    }

}
