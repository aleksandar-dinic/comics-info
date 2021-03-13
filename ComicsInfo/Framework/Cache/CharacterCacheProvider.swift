//
//  CharacterCacheProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct CharacterCacheProvider: CharacterCacheService {

    private let inMemoryCache: InMemoryCache<String, Character>

    init(_ inMemoryCache: InMemoryCache<String, Character> = InMemoryCache()) {
        self.inMemoryCache = inMemoryCache
    }

    func getAllCharacters() -> [Character]? {
        !inMemoryCache.isEmpty ? inMemoryCache.values : nil
    }

    func getCharacter(withID characterID: String) -> Character? {
        inMemoryCache[characterID]
    }

    func save(characters: [Character]) {
        for character in characters {
            inMemoryCache[character.identifier] = character
        }
    }

}
