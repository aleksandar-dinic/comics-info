//
//  CharacterCacheProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import SwiftUI
import Foundation
import Domain

struct CharacterCacheProvider: CharacterCacheService {
    
    static private var bookmarkKey = "BookmarkCharactersKey"

    private let characterCache: Cache<String, Character>
    private var defaults: UserDefaults

    init(
        _ characterCache: Cache<String, Character> = SwiftUI.Environment(\.characterCache).wrappedValue,
        defaults: UserDefaults = .standard
    ) {
        self.characterCache = characterCache
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
    
    // Bookmark
    
    func getBookmarkCharacters() -> [MyCharacter]? {
        let characters = getBookmarkedCharacters()
        
        return !characters.isEmpty ? characters.sorted() : nil
    }
    
    func addToBookmark(_ myCharacter: MyCharacter) {
        var characters = getBookmarkedCharacters()
        characters.append(myCharacter)
        setBookmarkedCharacters(characters)
    }
    
    func updateBookmared(_ myCharacter: MyCharacter) {
        var characters = getBookmarkedCharacters()
        if let index = characters.firstIndex(where: { $0.identifier == myCharacter.identifier }) {
            for series in myCharacter.mySeries ?? [] {
                characters[index].addInMySeries(series)
            }
        } else {
            characters.append(myCharacter)
        }
        setBookmarkedCharacters(characters)
    }
    
    func removeFromBookmark(_ myCharacter: MyCharacter) {
        var characters = getBookmarkedCharacters()
        guard let index = characters.firstIndex(where: { $0.identifier == myCharacter.identifier }) else { return }
        characters.remove(at: index)
        setBookmarkedCharacters(characters)
    }
    
    func isBookmarked(withID characterID: String) -> Bool {
        getBookmarkedCharacters().contains(where: { $0.identifier == characterID })
    }
    
    private func getBookmarkedCharacters() -> [MyCharacter] {
        guard let data = defaults.object(forKey: Self.bookmarkKey) as? Data else {
            return []
        }
        
        do {
            let bookmarkedCharacters = try JSONDecoder().decode([MyCharacter].self, from: data)
            return bookmarkedCharacters
        } catch {
            print(error)
        }
        return []
    }
    
    private func setBookmarkedCharacters(_ characters: [MyCharacter]) {
        do {
            let data = try JSONEncoder().encode(characters)
            defaults.set(data, forKey: Self.bookmarkKey)
        } catch {
            print(error)
        }
    }

}
