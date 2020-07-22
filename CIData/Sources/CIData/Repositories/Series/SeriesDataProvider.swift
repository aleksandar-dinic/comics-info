//
//  SeriesDataProvider.swift
//  CIData
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
import Foundation

public struct SeriesDataProvider {

    private let seriesAPIWrapper: SeriesAPIWrapper
    private let seriesCacheService: SeriesCacheService

    init(
        seriesAPIWrapper: SeriesAPIWrapper,
        seriesCacheService: SeriesCacheService
    ) {
        self.seriesAPIWrapper = seriesAPIWrapper
        self.seriesCacheService = seriesCacheService
    }

    func getSeries(
        forCharacterID characterID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Domain.Series], Error>) -> Void
    ) {
        switch dataSource {
        case .memory:
            if let seriesFromMemory = getSeriesFromMemory(forCharacterID: characterID) {
                return complete(.success(seriesFromMemory))
            }

        case .network:
            break
        }

        getSeriesFromNetwork(forCharacterID: characterID, onComplete: complete)
    }

    private func getSeriesFromMemory(forCharacterID characterID: String) -> [Domain.Series]? {
        guard let series = seriesCacheService.getSeries(forCharacterID: characterID) else {
            return nil
        }
        return series.isEmpty ? nil : series
    }

    private func getSeriesFromNetwork(
        forCharacterID characterID: String,
        onComplete complete: @escaping (Result<[Domain.Series], Error>) -> Void
    ) {
        seriesAPIWrapper.getSeries(forCharacterID: characterID) { (result: Result<[Domain.Series], Error>) in
            switch result {
            case let .success(series):
                self.seriesCacheService.save(series: series)
                complete(.success(series))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

}
