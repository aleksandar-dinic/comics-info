//
//  CharactersWithSeriesUseCaseAdapter.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 02/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import enum CIData.DataSourceLayer
import protocol UseCases.CharactersWithSeriesUseCaseFactory
import protocol CIData.SeriesAPIService
import protocol CIData.SeriesCacheService
import protocol CIData.SeriesDecoderService
import protocol CIData.CharacterAPIService
import protocol CIData.CharacterCacheService
import protocol CIData.CharacterDecoderService
import Foundation

final class CharactersWithSeriesUseCaseAdapter: UseCases.CharactersWithSeriesUseCaseFactory {

    private lazy var useCase = makeCharactersWithSeriesUseCase()

    var characterCacheService: CharacterCacheService
    var seriesCacheService: SeriesCacheService
    var characterAPIService: CharacterAPIService
    var characterDecoderService: CharacterDecoderService
    var seriesAPIService: SeriesAPIService
    var seriesDecoderService: SeriesDecoderService

    init(
        characterAPIService: CharacterAPIService = CharacterAPIProvider(),
        characterCacheService: CharacterCacheService = CharacterCacheProvider(),
        characterDecoderService: CharacterDecoderService = CharacterDecoderProvider(),
        seriesAPIService: SeriesAPIService = SeriesAPIProvider(),
        seriesCacheService: SeriesCacheService = SeriesCacheProvider(),
        seriesDecoderService: SeriesDecoderService = SeriesDecoderProvider()
    ) {
        self.characterAPIService = characterAPIService
        self.characterCacheService = characterCacheService
        self.characterDecoderService = characterDecoderService
        self.seriesAPIService = seriesAPIService
        self.seriesCacheService = seriesCacheService
        self.seriesDecoderService = seriesDecoderService
    }

    func getAllCharactersWithSeries(
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        useCase.getAllCharactersWithSeries(fromDataSource: dataSource) { result in
            complete(result.map { $0.map({ Character(from: $0) }) })
        }
    }

}
