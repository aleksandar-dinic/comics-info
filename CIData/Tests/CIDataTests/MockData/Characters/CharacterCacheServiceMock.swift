//
//  CharacterCacheServiceMock.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct CIData.Character
import protocol CIData.CharacterCacheService
import Foundation

final class CharacterCacheServiceMock: CharacterCacheService {

    private var characters: [String: Character]

    init(_ characters: [String: Character] = [:]) {
        self.characters = characters
    }

    func getAllCharacters() -> [Character]? {
        guard !characters.isEmpty else {
            return nil
        }
        return Array(characters.values)
    }

    func getCharacter(withID characterID: String) -> Character? {
        characters[characterID]
    }

    func save(characters: [Character]) {
        for character in characters {
            self.characters[character.identifier] = character
        }
    }

}

extension CharacterCacheServiceMock {

    func setCharacters(_ characters: [Character]) {
        for character in characters {
            self.characters[character.identifier] = character
        }
    }

    func setCharacter(_ character: Character) {
        characters[character.identifier] = character
    }

}
