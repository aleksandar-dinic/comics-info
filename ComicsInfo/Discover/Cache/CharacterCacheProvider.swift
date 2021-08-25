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

    func getAllCharacters(afterID: String?, limit: Int) -> [Character]? {
        var items = inMemoryCache.values
        items.sort()
        guard !items.isEmpty else { return nil }
        var start = 0
        let count = items.count

        if let afterID = afterID {
            guard let firstIndex = items.firstIndex(where: { $0.identifier == afterID }) else {
                return nil
            }
            start = firstIndex + 1
        }

        items = Array(items[start..<min(count, start+limit)])
        return !items.isEmpty ? items : nil
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
