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
    
    func getBookmarkCharacters() -> [MyCharacter]?
    func addToBookmark(_ myCharacter: MyCharacter)
    func updateBookmared(_ myCharacter: MyCharacter)
    func removeFromBookmark(_ myCharacter: MyCharacter)
    func isBookmarked(withID characterID: String) -> Bool

}
