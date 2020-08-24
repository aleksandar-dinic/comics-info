//
//  CharacterCacheProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct CIData.Character
import protocol CIData.CharacterCacheService
import Foundation

public struct CharacterCacheProvider: CIData.CharacterCacheService {

    private let inMemoryCache: InMemoryCache<String, Character>

    init(_ inMemoryCache: InMemoryCache<String, Character> = InMemoryCache()) {
        self.inMemoryCache = inMemoryCache
    }

    public func getAllCharacters() -> [CIData.Character]? {
        inMemoryCache.isEmpty ? nil : inMemoryCache.values.map({ CIData.Character(from: $0) })
    }

    public func getCharacter(withID characterID: String) -> CIData.Character? {
        guard let character = inMemoryCache[characterID] else {
            return nil
        }
        return CIData.Character(from: character)
    }

    public func save(characters: [CIData.Character]) {
        for character in characters {
            inMemoryCache[character.identifier] = Character(from: character)
        }
    }

}
