//
//  CharacterCacheServiceMock.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct CIData.Character
import protocol CIData.CharacterCacheService
import Foundation

final class CharacterCacheServiceMock: CharacterCacheService {

    private var characters: [String: CIData.Character]

    init(_ characters: [String: CIData.Character] = [:]) {
        self.characters = characters
    }

    func getAllCharacters() -> [CIData.Character]? {
        guard !characters.isEmpty else {
            return nil
        }
        return Array(characters.values)
    }

    func getCharacter(withID characterID: String) -> CIData.Character? {
        characters[characterID]
    }

    func save(characters: [CIData.Character]) {
        for character in characters {
            self.characters[character.identifier] = character
        }
    }

}

extension CharacterCacheServiceMock {

    func setCharacters(_ characters: [CIData.Character]) {
        for character in characters {
            self.characters[character.identifier] = character
        }
    }

    func setCharacter(_ character: CIData.Character) {
        characters[character.identifier] = character
    }

}
