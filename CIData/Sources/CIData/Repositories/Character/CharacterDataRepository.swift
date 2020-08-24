//
//  CharacterDataRepository.swift
//  CIData
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class CharacterDataRepository: CharacterRepository {

    let characterDataProvider: CharacterDataProvider

    init(characterDataProvider: CharacterDataProvider) {
        self.characterDataProvider = characterDataProvider
    }

    func getAllCharacters(
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        characterDataProvider.getAllCharacters(fromDataSource: dataSource, onComplete: complete)
    }

    func getCharacter(
        withID characterID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Character, Error>) -> Void
    ) {
        characterDataProvider.getCharacter(
            withID: characterID,
            fromDataSource: dataSource,
            onComplete: complete
        )
    }

}
