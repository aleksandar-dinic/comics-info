//
//  CharacterDataProvider.swift
//  CIData
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
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

    // Get Characters

    func getCharacters(
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Domain.Character], Error>) -> Void
    ) {
        switch dataSource {
        case .memory:
            if let charactersFromMemory = getCharactersFromMemory() {
                return complete(.success(charactersFromMemory))
            }

        case .network:
            break
        }

        getCharactersFromNetwork(onComplete: complete)
    }

    private func getCharactersFromMemory() -> [Domain.Character]? {
        guard let characters = characterCacheService.getCharacters() else {
            return nil
        }
        return characters.isEmpty ? nil : characters
    }

    private func getCharactersFromNetwork(
        onComplete complete: @escaping (Result<[Domain.Character], Error>) -> Void
    ) {
        characterAPIWrapper.getCharacters { (result: Result<[Domain.Character], Error>) in
            switch result {
            case let .success(characters):
                self.characterCacheService.save(characters: characters)
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
        onComplete complete: @escaping (Result<Domain.Character, Error>) -> Void
    ) {
        switch dataSource {
        case .memory:
            if let characterFromMemory = getCharacterFromMemory(withID: characterID) {
                return complete(.success(characterFromMemory))
            }
        case .network:
            break
        }
        getCharacterFromNetwork(withID: characterID, onComplete: complete)
    }

    private func getCharacterFromMemory(withID characterID: String) -> Domain.Character? {
        characterCacheService.getCharacter(withID: characterID)
    }

    private func getCharacterFromNetwork(
        withID characterID: String,
        onComplete complete: @escaping (Result<Domain.Character, Error>) -> Void
    ) {
        characterAPIWrapper.getCharacter(withID: characterID) { (result: Result<Domain.Character, Error>) in
            switch result {
            case let .success(character):
                self.characterCacheService.save(characters: [character])
                complete(.success(character))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

}
