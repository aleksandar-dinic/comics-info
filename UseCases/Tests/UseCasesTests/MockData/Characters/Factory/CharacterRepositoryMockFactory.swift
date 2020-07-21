//
//  CharacterRepositoryMockFactory.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import CIData
@testable import UseCases
import protocol CIData.CharacterRepository
import Foundation

struct CharacterRepositoryMockFactory {

    static func makeWithCharacters() -> CharacterRepository {
        let characterDataProvider = CharacterDataProviderMockFactory.makeWithCharacters()

        return CharacterDataRepository(characterDataProvider: characterDataProvider)
    }

    static func makeWithCharacter() -> CharacterRepository {
        let characterDataProvider = CharacterDataProviderMockFactory.makeWithCharacter()

        return CharacterDataRepository(characterDataProvider: characterDataProvider)
    }

}
