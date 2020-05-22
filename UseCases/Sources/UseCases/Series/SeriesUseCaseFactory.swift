//
//  SeriesUseCaseFactory.swift
//  UseCases
//
//  Created by Aleksandar Dinic on 22/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol CIData.SeriesRepositoryFactory
import Foundation

public protocol SeriesUseCaseFactory: CIData.SeriesRepositoryFactory {

    func makeSeriesUseCase() -> SeriesUseCase

}

extension SeriesUseCaseFactory {

    public func makeSeriesUseCase() -> SeriesUseCase {
        SeriesUseCase(seriesRepository: makeSeriesRepository())
    }

}
