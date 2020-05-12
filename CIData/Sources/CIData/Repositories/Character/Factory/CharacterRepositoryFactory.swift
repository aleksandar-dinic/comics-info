//
//  CharacterRepositoryFactory.swift
//  CIData
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol CharacterRepositoryFactory: CharacterDataProviderFactory {

    func makeCharacterRepository() -> CharacterRepository

}

extension CharacterRepositoryFactory {

    public func makeCharacterRepository() -> CharacterRepository {
        CharacterDataRepository(characterDataProvider: makeCharacterDataProvider())
    }

}
