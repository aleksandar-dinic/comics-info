//
//  SeriesAPIWrapperMockFactory.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 22/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import CIData
import Foundation

struct SeriesAPIWrapperMockFactory {

    static func makeWithSeries() -> SeriesAPIWrapper {
        let seriesAPIServiceMock = SeriesAPIServiceMock(SeriesMock.series)
        let seriesDecoderMock = SeriesDecoderMock(SeriesMock.domainSeries)

        return SeriesAPIWrapper(
            seriesAPIService: seriesAPIServiceMock,
            seriesDecoderService: seriesDecoderMock
        )
    }

}
