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
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Series], Error>) -> Void
    ) {
        switch dataSource {
        case .memory:
            if let seriesFromMemory = getAllSeriesFromMemory() {
                return complete(.success(seriesFromMemory))
            }
            fallthrough
        case .network:
            getAllSeriesFromNetwork(onComplete: complete)
        }
    }
    
    private func getAllSeriesFromMemory() -> [Series]? {
        guard let series = seriesCacheService.getAllSeries() else {
            return nil
        }
        return series.isEmpty ? nil : series
    }
    
    private func getAllSeriesFromNetwork(
        onComplete complete: @escaping (Result<[Series], Error>) -> Void
    ) {
        seriesAPIWrapper.getAllSeries() { (result: Result<[Series], Error>) in
            switch result {
            case let .success(series):
                seriesCacheService.save(series: series)
                complete(.success(series))

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
                seriesCacheService.save(series: [series])
                complete(.success(series))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

}
