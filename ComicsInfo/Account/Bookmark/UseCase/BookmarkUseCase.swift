//
//  BookmarkUseCase.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 28/09/2021.
//

import Foundation

final class BookmarkUseCase: CharacterRepositoryFactory, ComicRepositoryFactory {
    
    private lazy var characterRepository = makeCharacterRepository()
    private lazy var comicRepository = makeComicRepository()

    let characterAPIService: CharacterAPIService
    let characterCacheService: CharacterCacheService
    
    let comicAPIService: ComicAPIService
    let comicCacheService: ComicCacheService

    init(
        characterAPIService: CharacterAPIService = CharacterAPIProvider(),
        characterCacheService: CharacterCacheService = CharacterCacheProvider(),
        comicAPIService: ComicAPIService = ComicAPIProvider(),
        comicCacheService: ComicCacheService = ComicCacheProvider()
    ) {
        self.characterAPIService = characterAPIService
        self.characterCacheService = characterCacheService
        self.comicAPIService = comicAPIService
        self.comicCacheService = comicCacheService
    }
    
    func getBookmarkCharacters() -> [Character]? {
        characterCacheService.getBookmarkCharacters()
    }
    
    func getBookmarkComics() -> [Comic]? {
        comicCacheService.getBookmarkComics()
    }
    
}
