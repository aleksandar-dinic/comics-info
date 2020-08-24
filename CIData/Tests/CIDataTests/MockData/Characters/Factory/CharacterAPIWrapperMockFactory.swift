//
//  CharacterAPIWrapperMockFactory.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import CIData
import Foundation

struct CharacterAPIWrapperMockFactory {

    static func makeWithCharacters() -> CharacterAPIWrapper {
        let characterAPIServiceMock = CharacterAPIServiceMock(CharactersMock.charactersData)
        let characterDecoderService = CharacterDecoderMock(CharactersMock.domainCharacters)

        return CharacterAPIWrapper(
            characterAPIService: characterAPIServiceMock,
            characterDecoderService: characterDecoderService
        )
    }

    static func makeWithoutData() -> CharacterAPIWrapper {
        let characterAPIServiceMock = CharacterAPIServiceMock()
        let characterDecoderService = CharacterDecoderMock()

        return CharacterAPIWrapper(
            characterAPIService: characterAPIServiceMock,
            characterDecoderService: characterDecoderService
        )
    }

    static func makeWithCharactersBadData() -> CharacterAPIWrapper {
        let characterAPIServiceMock = CharacterAPIServiceMock(CharactersMock.charactersBadData)
        let characterDecoderService = CharacterDecoderMock()

        return CharacterAPIWrapper(
            characterAPIService: characterAPIServiceMock,
            characterDecoderService: characterDecoderService
        )
    }

    static func makeWithCharacter() -> CharacterAPIWrapper {
        let characterAPIServiceMock = CharacterAPIServiceMock(CharactersMock.characterData)
        let characterDecoderService = CharacterDecoderMock([CharactersMock.domainCharacter])

        return CharacterAPIWrapper(
            characterAPIService: characterAPIServiceMock,
            characterDecoderService: characterDecoderService
        )
    }

    static func makeWithCharacterBadData() -> CharacterAPIWrapper {
        let characterAPIServiceMock = CharacterAPIServiceMock(CharactersMock.characterBadData)
        let characterDecoderService = CharacterDecoderMock()

        return CharacterAPIWrapper(
            characterAPIService: characterAPIServiceMock,
            characterDecoderService: characterDecoderService
        )
    }

}
