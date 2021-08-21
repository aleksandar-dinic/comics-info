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
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.getAllCharacters(fromDataSource: dataSource) { result in
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

}
