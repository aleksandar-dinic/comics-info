//
//  CharacterCacheServiceMock.swift
//  CIDataTests
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
import protocol CIData.CharacterCacheService
import Foundation

final class CharacterCacheServiceMock: CharacterCacheService {

    private var characters: [String: Domain.Character]

    init(_ characters: [String: Domain.Character] = [:]) {
        self.characters = characters
    }

    func getCharacters() -> [Domain.Character]? {
        guard !characters.isEmpty else {
            return nil
        }
        return Array(characters.values)
    }

    func getCharacter(withID characterID: String) -> Domain.Character? {
        characters[characterID]
    }

    func save(characters: [Domain.Character]) {
        for character in characters {
            self.characters[character.identifier] = character
        }
    }

}

extension CharacterCacheServiceMock {

    func setCharacters(_ data: Data?) {
        guard let data = data else {
            return
        }

        do {
            let characters = try JSONDecoder().decode([Domain.Character].self, from: data)
            for character in characters {
                self.characters[character.identifier] = character
            }
        } catch {
            print(error)
        }
    }

    func setCharacter(_ data: Data?) {
        guard let data = data else {
            return
        }

        do {
            let character = try JSONDecoder().decode(Domain.Character.self, from: data)
            self.characters[character.identifier] = character
        } catch {
            print(error)
        }
    }

}
