//
//  CharacterCacheProvider.swift
//  Framework
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
import protocol CIData.CharacterCacheService
import Foundation

public struct CharacterCacheProvider: CIData.CharacterCacheService {

    private let inMemoryCache: InMemoryCache<String, Domain.Character>

    init(_ inMemoryCache: InMemoryCache<String, Domain.Character> = InMemoryCache()) {
        self.inMemoryCache = inMemoryCache
    }

    public func getAllCharacters() -> [Domain.Character]? {
        inMemoryCache.isEmpty ? nil : inMemoryCache.values
    }

    public func getCharacter(withID characterID: String) -> Domain.Character? {
        inMemoryCache[characterID]
    }

    public func save(characters: [Domain.Character]) {
        for character in characters {
            inMemoryCache[character.identifier] = character
        }
    }

}
