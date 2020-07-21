//
//  SeriesDataRepository.swift
//  CIData
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
import Foundation

final class SeriesDataRepository: SeriesRepository {

    var seriesDataProvider: SeriesDataProvider

    init(seriesDataProvider: SeriesDataProvider) {
        self.seriesDataProvider = seriesDataProvider
    }

    func getSeries(
        forCharacterID characterID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Domain.Series], Error>) -> Void
    ) {
        seriesDataProvider.getSeries(
            forCharacterID: characterID,
            fromDataSource: dataSource,
            onComplete: complete
        )
    }

}
