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
    
    static private var bookmarkKey = "BookmarkCharactersKey"

    private let characterCache: Cache<String, Character>
    private let myCharacterCache: Cache<String, Character>
    private var defaults: UserDefaults

    init(
        _ characterCache: Cache<String, Character> = SwiftUI.Environment(\.characterCache).wrappedValue,
        _ myCharacterCache: Cache<String, Character>  = SwiftUI.Environment(\.myCharacterCache).wrappedValue,
        defaults: UserDefaults = .standard
    ) {
        self.characterCache = characterCache
        self.myCharacterCache = myCharacterCache
        self.defaults = defaults
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
    
    // My Characters
    
    func getMyCharacters() -> [Character]? {
        myCharacterCache.values()?.sorted()
    }
    
    func addToMyCharacters(_ character: Character) {
        var character = character
        
        if var mySeries = myCharacterCache[character.identifier]?.mySeries {
            var dict = [String: Int]()
            for (i, el) in mySeries.enumerated() {
                dict[el.identifier] = i
            }
            
            for series in character.mySeries ?? [] {
                guard dict[series.identifier] == nil else { continue }
                dict[series.identifier] = mySeries.count
                mySeries.append(series)
            }
            character.mySeries = mySeries.sorted()
        }
        
        myCharacterCache[character.identifier] = character
        try? myCharacterCache.saveToDisc(.myCharacters)
    }
    
    func updateInMyCharacters(_ character: Character) {
        myCharacterCache[character.identifier] = character
        try? myCharacterCache.saveToDisc(.myCharacters)
    }
    
    func removeFromMyCharacters(_ character: Character) {
        myCharacterCache.removeValue(forKey: character.identifier)
        try? myCharacterCache.saveToDisc(.myCharacters)
    }
    
    func isInMyCharacters(withID characterID: String) -> Bool {
        myCharacterCache[characterID] != nil
    }
    
    // Bookmark
    
    func getBookmarkCharacters() -> [Character]? {
        var characters = [Character]()
        for id in getBookmarkedCharacters() {
            guard let character = getCharacter(withID: id) else { continue }
            characters.append(character)
        }
        characters.sort()
        return !characters.isEmpty ? characters : nil
    }
    
    func addToBookmark(_ character: Character) {
        var characters = getBookmarkedCharacters()
        characters.insert(character.identifier)
        defaults.set(Array(characters), forKey: Self.bookmarkKey)
    }
    
    func removeFromBookmark(_ character: Character) {
        var characters = getBookmarkedCharacters()
        characters.remove(character.identifier)
        defaults.set(Array(characters), forKey: Self.bookmarkKey)
    }
    
    func isBookmarked(withID characterID: String) -> Bool {
        getBookmarkedCharacters().contains(characterID)
    }
    
    private func getBookmarkedCharacters() -> Set<String> {
        Set(defaults.object(forKey: Self.bookmarkKey) as? [String] ?? [String]())
    }

}
