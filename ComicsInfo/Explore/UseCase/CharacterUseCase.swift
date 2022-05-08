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
    private lazy var myComicsUseCase = MyComicsUseCase()

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
    
    // MyCharacters
    
    func addToMyCharacters(
        _ myCharacter: MyCharacter,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        myComicsUseCase.addToMyCharacters(myCharacter, onComplete: complete)
    }
    
    func getAllMyCharacters(
        onComplete complete: @escaping (Result<[MyCharacter], Error>) -> Void
    ) {
        myComicsUseCase.getAllMyCharacters(onComplete: complete)
    }
    
    func isInMyCharacters(
        withID myCharacterID: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        myComicsUseCase.getMyCharacter(withID: myCharacterID) { result in
            switch result {
            case .success:
                complete(.success(()))
            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    func removeMyCharacter(
        withID myCharacterID: String,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        myComicsUseCase.removeMyCharacter(withID: myCharacterID, onComplete: complete)
    }
    
    // Bookmark
    
    func getBookmarkCharacters() -> [MyCharacter]? {
        repository.getBookmarkCharacters()
    }
    
    func addToBookmark(_ myCharacter: MyCharacter) {
        repository.addToBookmark(myCharacter)
    }
    
    func updateBookmared(_ myCharacter: MyCharacter) {
        repository.updateBookmared(myCharacter)
    }
    
    func removeFromBookmark(_ myCharacter: MyCharacter) {
        repository.removeFromBookmark(myCharacter)
    }
    
    func isBookmarked(withID characterID: String) -> Bool {
        repository.isBookmarked(withID: characterID)
    }

}
