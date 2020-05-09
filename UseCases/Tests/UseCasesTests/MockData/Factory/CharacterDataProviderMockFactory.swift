//
//  CharacterDataProviderMockFactory.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import CIData
import Foundation

struct CharacterDataProviderMockFactory {

    static func makeWithCharacters() -> CharacterDataProvider {
        let characterAPIWrapper = CharacterAPIWrapperMockFactory.makeWithCharacters()
        let characterCacheService = CharacterCacheServiceMock()

        return CharacterDataProvider(
            characterAPIWrapper: characterAPIWrapper,
            characterCacheService: characterCacheService
        )
    }

    static func makeWithCharacter() -> CharacterDataProvider {
        let characterAPIWrapper = CharacterAPIWrapperMockFactory.makeWithCharacter()
        let characterCacheService = CharacterCacheServiceMock()

        return CharacterDataProvider(
            characterAPIWrapper: characterAPIWrapper,
            characterCacheService: characterCacheService
        )
    }

}
