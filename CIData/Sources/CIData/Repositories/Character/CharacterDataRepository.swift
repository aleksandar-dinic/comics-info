//
//  CharacterDataRepository.swift
//  CIData
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
import Foundation

final class CharacterDataRepository: CharacterRepository {

    let characterDataProvider: CharacterDataProvider

    init(characterDataProvider: CharacterDataProvider) {
        self.characterDataProvider = characterDataProvider
    }

    func getCharacters(
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Domain.Character], Error>) -> Void
    ) {
        characterDataProvider.getCharacters(fromDataSource: dataSource, onComplete: complete)
    }

    func getCharacter(
        withID characterID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Domain.Character, Error>) -> Void
    ) {
        characterDataProvider.getCharacter(
            withID: characterID,
            fromDataSource: dataSource,
            onComplete: complete
        )
    }

}
