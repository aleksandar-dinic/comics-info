//
//  CharacterUseCaseAdapter.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import enum CIData.DataSourceLayer
import protocol CIData.CharacterAPIService
import protocol CIData.CharacterCacheService
import protocol CIData.CharacterDecoderService
import protocol UseCases.CharacterUseCaseFactory
import Foundation

struct CharacterUseCaseAdapter: UseCases.CharacterUseCaseFactory {

    private lazy var useCase = makeCharacterUseCase()

    let characterAPIService: CharacterAPIService
    let characterCacheService: CharacterCacheService
    let characterDecoderService: CharacterDecoderService

    init(
        characterAPIService: CharacterAPIService = CharacterAPIProvider(),
        characterCacheService: CharacterCacheService = CharacterCacheProvider(),
        characterDecoderService: CharacterDecoderService = CharacterDecoderProvider()
    ) {
        self.characterAPIService = characterAPIService
        self.characterCacheService = characterCacheService
        self.characterDecoderService = characterDecoderService
    }

    mutating func getAllCharacters(
        fromDataSource dataSource: CIData.DataSourceLayer,
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        useCase.getAllCharacters(fromDataSource: dataSource) { result in
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
