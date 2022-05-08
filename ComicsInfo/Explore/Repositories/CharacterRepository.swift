//
//  CharacterRepository.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol CharacterRepository {

    var characterDataProvider: CharacterDataProvider { get }

    init(characterDataProvider: CharacterDataProvider)

    func getAllCharacters(
        afterID: String?,
        fields: Set<String>?,
        limit: Int,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    )

    func getCharacter(
        withID characterID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Character, Error>) -> Void
    )
    
    func getBookmarkCharacters() -> [MyCharacter]?
    func addToBookmark(_ myCharacter: MyCharacter)
    func updateBookmared(_ myCharacters: MyCharacter)
    func removeFromBookmark(_ myCharacter: MyCharacter)
    func isBookmarked(withID characterID: String) -> Bool

}
