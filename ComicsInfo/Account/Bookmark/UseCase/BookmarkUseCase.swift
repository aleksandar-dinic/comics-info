//
//  BookmarkUseCase.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 28/09/2021.
//

import Foundation

final class BookmarkUseCase: CharacterRepositoryFactory, SeriesRepositoryFactory, ComicRepositoryFactory {
    
    private lazy var comicRepository = makeComicRepository()
    lazy var characterRepository = makeCharacterRepository()
    lazy var seriesRepository = makeSeriesRepository()

    let characterAPIService: CharacterAPIService
    let characterCacheService: CharacterCacheService
    
    let seriesAPIService: SeriesAPIService
    let seriesCacheService: SeriesCacheService
    
    let comicAPIService: ComicAPIService
    let comicCacheService: ComicCacheService

    init(
        characterAPIService: CharacterAPIService = CharacterAPIProvider(),
        characterCacheService: CharacterCacheService = CharacterCacheProvider(),
        seriesAPIService: SeriesAPIService = SeriesAPIProvider(),
        seriesCacheService: SeriesCacheService = SeriesCacheProvider(),
        comicAPIService: ComicAPIService = ComicAPIProvider(),
        comicCacheService: ComicCacheService = ComicCacheProvider()
    ) {
        self.characterAPIService = characterAPIService
        self.characterCacheService = characterCacheService
        self.seriesAPIService = seriesAPIService
        self.seriesCacheService = seriesCacheService
        self.comicAPIService = comicAPIService
        self.comicCacheService = comicCacheService
    }
    
    func getBookmarkCharacters() -> [Character]? {
        characterRepository.getBookmarkCharacters()
    }
    
    func getBookmarkComics() -> [Comic]? {
        comicRepository.getBookmarkComics()
    }
    
}
