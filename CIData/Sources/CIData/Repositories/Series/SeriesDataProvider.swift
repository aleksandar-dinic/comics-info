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

    func getAllSeries(
        forCharacters characters: [String],
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Domain.Series], Error>) -> Void
    ) {
        switch dataSource {
        case .memory:
            if let seriesFromMemory = getAllSeriesFromMemory(forCharacters: characters) {
                return complete(.success(seriesFromMemory))
            }

        case .network:
            break
        }

        getAllSeriesFromNetwork(forCharacters: characters, onComplete: complete)
    }

    private func getAllSeriesFromMemory(forCharacters characters: [String]) -> [Domain.Series]? {
        guard let series = seriesCacheService.getAllSeries(forCharacters: characters) else {
            return nil
        }
        return series.isEmpty ? nil : series
    }

    private func getAllSeriesFromNetwork(
        forCharacters characters: [String],
        onComplete complete: @escaping (Result<[Domain.Series], Error>) -> Void
    ) {
        seriesAPIWrapper.getAllSeries(forCharacters: characters) { (result: Result<[Domain.Series], Error>) in
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
