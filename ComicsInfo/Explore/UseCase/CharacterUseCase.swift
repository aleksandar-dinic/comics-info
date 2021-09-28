//
//  CharacterUseCase.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class CharacterUseCase: CharacterRepositoryFactory {

    private lazy var repository = makeCharacterRepository()

    let characterAPIService: CharacterAPIService
    let characterCacheService: CharacterCacheService

    init(
        characterAPIService: CharacterAPIService = CharacterAPIProvider(),
        characterCacheService: CharacterCacheService = CharacterCacheProvider()
    ) {
        self.characterAPIService = characterAPIService
        self.characterCacheService = characterCacheService
    }

    func getAllCharacters(
        afterID: String?,
        fields: Set<String>?,
        limit: Int,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.getAllCharacters(afterID: afterID, fields: fields, limit: limit, fromDataSource: dataSource) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }

    func getCharacter(
        withID characterID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Character, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.getCharacter(withID: characterID, fromDataSource: dataSource) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }
    
    func getBookmarkCharacters() -> [Character]? {
        repository.getBookmarkCharacters()
    }
    
    func addToBookmark(_ character: Character) {
        repository.addToBookmark(character)
    }
    
    func removeFromBookmark(_ character: Character) {
        repository.removeFromBookmark(character)
    }
    
    func isBookmarked(withID characterID: String) -> Bool {
        repository.isBookmarked(withID: characterID)
    }

}
