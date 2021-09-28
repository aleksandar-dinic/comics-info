//
//  CharacterCacheServiceMock.swift
//  ComicsInfoTests
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

@testable import struct Comics_Info__Development_.Character
@testable import protocol Comics_Info__Development_.CharacterCacheService
import Foundation

final class CharacterCacheServiceMock: CharacterCacheService {

    private var characters: [String: Character]

    init(_ characters: [String: Character] = [:]) {
        self.characters = characters
    }

    func getAllCharacters(
        afterID: String?,
        limit: Int
    ) -> [Character]? {
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
