//
//  CharacterDataProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct CharacterDataProvider {

    private let characterAPIWrapper: CharacterAPIWrapper
    private let characterCacheService: CharacterCacheService

    init(
        characterAPIWrapper: CharacterAPIWrapper,
        characterCacheService: CharacterCacheService
    ) {
        self.characterAPIWrapper = characterAPIWrapper
        self.characterCacheService = characterCacheService
    }

    // Get all characters

    func getAllCharacters(
        afterID: String?,
        fields: Set<String>?,
        limit: Int,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        switch dataSource {
        case .memory:
            if let charactersFromMemory = getAllCharactersFromMemory(afterID: afterID, limit: limit) {
                return complete(.success(charactersFromMemory))
            }
            fallthrough
        case .network:
            getAllCharactersFromNetwork(afterID: afterID, fields: fields, limit: limit, onComplete: complete)
        }
    }

    private func getAllCharactersFromMemory(afterID: String?, limit: Int) -> [Character]? {
        guard let characters = characterCacheService.getAllCharacters(afterID: afterID, limit: limit) else {
            return nil
        }
        return characters.isEmpty ? nil : characters
    }

    private func getAllCharactersFromNetwork(
        afterID: String?,
        fields: Set<String>?,
        limit: Int,
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        characterAPIWrapper.getAllCharacters(afterID: afterID, fields: fields, limit: limit) { (result: Result<[Character], Error>) in
            switch result {
            case let .success(characters):
                characterCacheService.save(characters: characters)
                complete(.success(characters.sorted()))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

    // Get Character

    func getCharacter(
        withID characterID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Character, Error>) -> Void
    ) {
        switch dataSource {
        case .memory:
            if let characterFromMemory = getCharacterFromMemory(withID: characterID) {
                return complete(.success(characterFromMemory))
            }
            fallthrough
        case .network:
            getCharacterFromNetwork(withID: characterID, onComplete: complete)
        }
    }

    private func getCharacterFromMemory(withID characterID: String) -> Character? {
        characterCacheService.getCharacter(withID: characterID)
    }

    private func getCharacterFromNetwork(
        withID characterID: String,
        onComplete complete: @escaping (Result<Character, Error>) -> Void
    ) {
        characterAPIWrapper.getCharacter(withID: characterID) { (result: Result<Character, Error>) in
            switch result {
            case let .success(character):
                characterCacheService.save(characters: [character])
                complete(.success(character))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    // Bookmark
    
    func getBookmarkCharacters() -> [MyCharacter]? {
        characterCacheService.getBookmarkCharacters()
    }
    
    func addToBookmark(_ myCharacter: MyCharacter) {
        characterCacheService.addToBookmark(myCharacter)
    }
    
    func updateBookmared(_ myCharacter: MyCharacter) {
        characterCacheService.updateBookmared(myCharacter)
    }
    
    func removeFromBookmark(_ myCharacter: MyCharacter) {
        characterCacheService.removeFromBookmark(myCharacter)
    }
    
    func isBookmarked(withID characterID: String) -> Bool {
        characterCacheService.isBookmarked(withID: characterID)
    }

}
