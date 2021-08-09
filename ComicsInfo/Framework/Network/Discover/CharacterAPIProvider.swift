//
//  CharacterAPIProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct CharacterAPIProvider: CharacterAPIService {

    func getAllCharacters(
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        usleep(useconds_t(Int.random(in: 500_000...2_000_000)))
        guard let data = CharactersMock().data else {
            return complete(.failure(NetworkError.missingData))
        }
        complete(.success(data))
    }

    func getCharacter(
        withID characterID: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        usleep(useconds_t(Int.random(in: 500_000...2_000_000)))
        guard let characterData = CharactersMock().characters[characterID], let data = characterData else {
            return complete(.failure(NetworkError.missingData))
        }
        complete(.success(data))
    }

}
