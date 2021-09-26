//
//  SeriesDataProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct SeriesDataProvider {

    private let seriesAPIWrapper: SeriesAPIWrapper
    private let seriesCacheService: SeriesCacheService

    init(
        seriesAPIWrapper: SeriesAPIWrapper,
        seriesCacheService: SeriesCacheService
    ) {
        self.seriesAPIWrapper = seriesAPIWrapper
        self.seriesCacheService = seriesCacheService
    }
    
    // Get All Series
    
    func getAllSeries(
        for characterID: String,
        afterID: String?,
        limit: Int,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[SeriesSummary], Error>) -> Void
    ) {
        switch dataSource {
        case .memory:
            if let seriesFromMemory = getAllSeriesFromMemory(for: characterID, afterID: afterID, limit: limit) {
                return complete(.success(seriesFromMemory))
            }
            fallthrough
        case .network:
            getAllSeriesFromNetwork(for: characterID, afterID: afterID, limit: limit, onComplete: complete)
        }
    }
    
    private func getAllSeriesFromMemory(
        for characterID: String,
        afterID: String?,
        limit: Int
    ) -> [SeriesSummary]? {
        guard let series = seriesCacheService.getAllSeries(for: characterID, afterID: afterID, limit: limit) else {
            return nil
        }
        return series.isEmpty ? nil : series
    }
    
    private func getAllSeriesFromNetwork(
        for characterID: String,
        afterID: String?,
        limit: Int,
        onComplete complete: @escaping (Result<[SeriesSummary], Error>) -> Void
    ) {
        seriesAPIWrapper.getAllSeries(for: characterID, afterID: afterID, limit: limit) { (result: Result<[SeriesSummary], Error>) in
            switch result {
            case let .success(seriesSummaries):
                seriesCacheService.save(seriesSummaries: seriesSummaries, forCharacterID: characterID)
                complete(.success(seriesSummaries))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    // Get Series

    func getSeries(
        withID seriesID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Series, Error>) -> Void
    ) {
        switch dataSource {
        case .memory:
            if let seriesFromMemory = getSeriesFromMemory(withID: seriesID) {
                return complete(.success(seriesFromMemory))
            }
            fallthrough
        case .network:
            getSeriesFromNetwork(withID: seriesID, onComplete: complete)
        }
    }

    private func getSeriesFromMemory(withID seriesID: String) -> Series? {
        seriesCacheService.getSeries(withID: seriesID)
    }

    private func getSeriesFromNetwork(
        withID seriesID: String,
        onComplete complete: @escaping (Result<Series, Error>) -> Void
    ) {
        seriesAPIWrapper.getSeries(withID: seriesID) { (result: Result<Series, Error>) in
            switch result {
            case let .success(series):
                seriesCacheService.save(series: series)
                complete(.success(series))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

}
