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
    
    // Bookmark
    
    func getBookmarkCharacters() -> [MyCharacter]? {
        characterDataProvider.getBookmarkCharacters()
    }
    
    func addToBookmark(_ myCharacter: MyCharacter) {
        characterDataProvider.addToBookmark(myCharacter)
    }
    
    func updateBookmared(_ myCharacter: MyCharacter) {
        characterDataProvider.updateBookmared(myCharacter)
    }
    
    func removeFromBookmark(_ myCharacter: MyCharacter) {
        characterDataProvider.removeFromBookmark(myCharacter)
    }
    
    func isBookmarked(withID characterID: String) -> Bool {
        characterDataProvider.isBookmarked(withID: characterID)
    }

}
