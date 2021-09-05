//
//  CharacterRepositoryFactory.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol CharacterRepositoryFactory: CharacterDataProviderFactory {

    func makeCharacterRepository() -> CharacterRepository

}

extension CharacterRepositoryFactory {

    func makeCharacterRepository() -> CharacterRepository {
        CharacterDataRepository(characterDataProvider: makeCharacterDataProvider())
    }

}
