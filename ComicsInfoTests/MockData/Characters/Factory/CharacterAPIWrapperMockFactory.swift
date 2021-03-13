//
//  CharacterAPIWrapperMockFactory.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import ComicsInfo
import Foundation

struct CharacterAPIWrapperMockFactory {

    static func makeWithCharacters() -> CharacterAPIWrapper {
        let characterAPIServiceMock = CharacterAPIServiceMock(CharactersMock.charactersData)

        return CharacterAPIWrapper(characterAPIService: characterAPIServiceMock)
    }

    static func makeWithoutData() -> CharacterAPIWrapper {
        let characterAPIServiceMock = CharacterAPIServiceMock()

        return CharacterAPIWrapper(characterAPIService: characterAPIServiceMock)
    }

    static func makeWithCharactersBadData() -> CharacterAPIWrapper {
        let characterAPIServiceMock = CharacterAPIServiceMock(CharactersMock.charactersBadData)

        return CharacterAPIWrapper(characterAPIService: characterAPIServiceMock)
    }

    static func makeWithCharacter() -> CharacterAPIWrapper {
        let characterAPIServiceMock = CharacterAPIServiceMock(CharactersMock.characterData)

        return CharacterAPIWrapper(characterAPIService: characterAPIServiceMock)
    }

    static func makeWithCharacterBadData() -> CharacterAPIWrapper {
        let characterAPIServiceMock = CharacterAPIServiceMock(CharactersMock.characterBadData)

        return CharacterAPIWrapper(characterAPIService: characterAPIServiceMock)
    }

}
