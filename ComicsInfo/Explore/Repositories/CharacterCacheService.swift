//
//  CharacterCacheService.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol CharacterCacheService {

    func getAllCharacters(
        afterID: String?,
        limit: Int
    ) -> [Character]?

    func getCharacter(withID characterID: String) -> Character?

    func save(characters: [Character])
    
    func getMyCharacters() -> [Character]?
    func addToMyCharacters(_ character: Character)
    func removeFromMyCharacters(_ character: Character)
    func isInMyCharacters(withID characterID: String) -> Bool
    
    func getBookmarkCharacters() -> [Character]?
    func addToBookmark(_ character: Character)
    func removeFromBookmark(_ character: Character)
    func isBookmarked(withID characterID: String) -> Bool

}
