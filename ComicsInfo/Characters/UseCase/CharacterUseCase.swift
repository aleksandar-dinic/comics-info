//
//  CharacterUseCase.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol UseCases.CharacterUseCaseFactory
import enum CIData.DataSourceLayer
import protocol CIData.CharacterCacheService
import protocol CIData.CharacterAPIService
import Foundation

struct CharacterUseCase: UseCases.CharacterUseCaseFactory {

    private lazy var useCase = makeCharacterUseCase()

    let characterAPIService: CharacterAPIService
    let characterCacheService: CharacterCacheService

    init(
        characterAPIService: CharacterAPIService = CharacterAPIProviderFactory().makeCharacterAPIProvider(),
        characterCacheService: CharacterCacheService = CharacterCacheProviderFactory().makeCharacterCacheProvider()
    ) {
        self.characterAPIService = characterAPIService
        self.characterCacheService = characterCacheService
    }

    mutating func getCharacters(
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        useCase.getCharacters(fromDataSource: dataSource) { result in
            complete(result.map { $0.map { Character(from: $0) } })
        }
    }

    mutating func getCharacter(
        withID characterID: String,
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<Character, Error>) -> Void
    ) {
        useCase.getCharacter(withID: characterID, fromDataSource: dataSource) { result in
            complete(result.map { Character(from: $0) })
        }
    }

}
