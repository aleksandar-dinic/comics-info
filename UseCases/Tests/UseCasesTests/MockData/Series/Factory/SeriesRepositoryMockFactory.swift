//
//  SeriesRepositoryMockFactory.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 22/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import CIData
@testable import UseCases
import protocol CIData.SeriesRepository
import Foundation

struct SeriesRepositoryMockFactory {

    static func makeWithSeries() -> SeriesRepository {
        let seriesDataProvider = SeriesDataProviderMockFactory.makeWithSeries()

        return SeriesDataRepository(seriesDataProvider: seriesDataProvider)
    }

}
