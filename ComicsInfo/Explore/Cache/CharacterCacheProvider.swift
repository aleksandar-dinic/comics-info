//
//  CharacterCacheProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI
import Foundation

struct CharacterCacheProvider: CharacterCacheService {

    private let characterCache: Cache<String, Character>

    init(
        _ characterCache: Cache<String, Character> = SwiftUI.Environment(\.characterCache).wrappedValue
    ) {
        self.characterCache = characterCache
    }

    func getAllCharacters(afterID: String?, limit: Int) -> [Character]? {
        guard var items = characterCache.values() else { return nil }
        items.sort()
        for (i, _) in items.enumerated() {
            items[i].mainSeries?.sort()
        }
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
        characterCache[characterID]
    }

    func save(characters: [Character]) {
        for character in characters {
            characterCache[character.identifier] = character
        }
        try? characterCache.saveToDisc(.characters)
    }

}
