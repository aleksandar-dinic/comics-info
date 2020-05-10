//
//  CharacterUseCase.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
import protocol UseCases.CharacterUseCaseFactory
import enum CIData.DataSourceLayer
import protocol CIData.CharacterCacheService
import protocol CIData.CharacterAPIService
import Foundation

final class CharacterUseCase: UseCases.CharacterUseCaseFactory {

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

    func getCharacters(
        fromDataSource dataSource: CIData.DataSourceLayer = .memory,
        onComplete complete: @escaping (Result<[Domain.Character], Error>) -> Void
    ) {
        useCase.getCharacters(
            fromDataSource: dataSource,
            onComplete: complete
        )
    }

    func getCharacter(
        withID characterID: String,
        fromDataSource dataSource: CIData.DataSourceLayer = .memory,
        onComplete complete: @escaping (Result<Domain.Character, Error>) -> Void
    ) {
        useCase.getCharacter(
            withID: characterID,
            fromDataSource: dataSource,
            onComplete: complete
        )
    }

}
