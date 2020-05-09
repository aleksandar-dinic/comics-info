//
//  CharacterAPIWrapperMockFactory.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import CIData
import Foundation

struct CharacterAPIWrapperMockFactory {

    static func makeWithCharacters() -> CharacterAPIWrapper {
        let characterAPIServiceMock = CharacterAPIServiceMock(CharactersMock.characters)

        return CharacterAPIWrapper(characterAPIService: characterAPIServiceMock)
    }

    static func makeWithCharacter() -> CharacterAPIWrapper {
        let characterAPIServiceMock = CharacterAPIServiceMock(CharactersMock.character)

        return CharacterAPIWrapper(characterAPIService: characterAPIServiceMock)
    }

}
