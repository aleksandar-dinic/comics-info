//
//  SeriesUseCase.swift
//  UseCases
//
//  Created by Aleksandar Dinic on 22/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol CIData.SeriesRepository
import enum CIData.DataSourceLayer
import struct CIData.Series
import Foundation

public final class SeriesUseCase {

    private let seriesRepository: SeriesRepository

    init(seriesRepository: SeriesRepository) {
        self.seriesRepository = seriesRepository
    }

    public func getAllSeries(
        forCharacters characters: [String],
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[CIData.Series], Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.seriesRepository.getAllSeries(forCharacters: characters, fromDataSource: dataSource) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }

}
