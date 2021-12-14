//
//  MyComicsUseCase.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 31/10/2021.
//

import Foundation

final class MyComicsUseCase: CharacterRepositoryFactory, SeriesRepositoryFactory {
    
    private lazy var characterRepository = makeCharacterRepository()
    private lazy var seriesRepository = makeSeriesRepository()
    
    let characterAPIService: CharacterAPIService
    let characterCacheService: CharacterCacheService
    
    let seriesAPIService: SeriesAPIService
    let seriesCacheService: SeriesCacheService
    
    init(
        characterAPIService: CharacterAPIService = CharacterAPIProvider(),
        characterCacheService: CharacterCacheService = CharacterCacheProvider(),
        seriesAPIService: SeriesAPIService = SeriesAPIProvider(),
        seriesCacheService: SeriesCacheService = SeriesCacheProvider()
    ) {
        self.characterAPIService = characterAPIService
        self.characterCacheService = characterCacheService
        self.seriesAPIService = seriesAPIService
        self.seriesCacheService = seriesCacheService
    }
    
    func getMyCharacters() -> [Character]? {
        characterRepository.getMyCharacters()
    }
    
    func getMySeries(for characterID: String) -> [SeriesSummary]? {
        seriesRepository.getMySeries(for: characterID)
    }
    
}
