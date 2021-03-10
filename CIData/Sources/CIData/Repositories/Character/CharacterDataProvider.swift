//
//  CharacterDataProvider.swift
//  CIData
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public struct CharacterDataProvider {

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
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        switch dataSource {
        case .memory:
            if let charactersFromMemory = getAllCharactersFromMemory() {
                return complete(.success(charactersFromMemory))
            }
            fallthrough
        case .network:
            getAllCharactersFromNetwork(onComplete: complete)
        }
    }

    private func getAllCharactersFromMemory() -> [Character]? {
        guard let characters = characterCacheService.getAllCharacters() else {
            return nil
        }
        return characters.isEmpty ? nil : characters
    }

    private func getAllCharactersFromNetwork(
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        characterAPIWrapper.getAllCharacters { (result: Result<[Character], Error>) in
            switch result {
            case let .success(characters):
                characterCacheService.save(characters: characters)
                complete(.success(characters))

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

}
