//
//  CharacterDataRepository.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class CharacterDataRepository: CharacterRepository {

    let characterDataProvider: CharacterDataProvider

    init(characterDataProvider: CharacterDataProvider) {
        self.characterDataProvider = characterDataProvider
    }

    func getAllCharacters(
        afterID: String?,
        fields: Set<String>?,
        limit: Int,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        characterDataProvider.getAllCharacters(
            afterID: afterID,
            fields: fields,
            limit: limit,
            fromDataSource: dataSource,
            onComplete: complete
        )
    }

    func getCharacter(
        withID characterID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Character, Error>) -> Void
    ) {
        characterDataProvider.getCharacter(
            withID: characterID,
            fromDataSource: dataSource,
            onComplete: complete
        )
    }
    
    // My Characters
    
    func getMyCharacters() -> [Character]? {
        characterDataProvider.getMyCharacters()
    }
    
    func addToMyCharacters(_ character: Character) {
        characterDataProvider.addToMyCharacters(character)
    }
    
    func updateInMyCharacters(_ character: Character) {
        characterDataProvider.updateInMyCharacters(character)
    }
    
    func removeFromMyCharacters(_ character: Character) {
        characterDataProvider.removeFromMyCharacters(character)
    }
    
    func isInMyCharacters(withID characterID: String) -> Bool {
        characterDataProvider.isInMyCharacters(withID: characterID)
    }
    
    // Bookmark
    
    func getBookmarkCharacters() -> [Character]? {
        characterDataProvider.getBookmarkCharacters()
    }
    
    func addToBookmark(_ character: Character) {
        characterDataProvider.addToBookmark(character)
    }
    
    func removeFromBookmark(_ character: Character) {
        characterDataProvider.removeFromBookmark(character)
    }
    
    func isBookmarked(withID characterID: String) -> Bool {
        characterDataProvider.isBookmarked(withID: characterID)
    }

}
