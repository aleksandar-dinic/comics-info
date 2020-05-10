//
//  CharacterAPIProvider.swift
//  Framework
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol CIData.CharacterAPIService
import Foundation

public struct CharacterAPIProvider: CIData.CharacterAPIService {

    public func getCharacters(
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        usleep(useconds_t(Int.random(in: 500_000...2_000_000)))
        guard let data = CharactersMock().data else {
            return complete(.failure(NetworkError.noData))
        }
        complete(.success(data))
    }

    public func getCharacter(
        withID characterID: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        usleep(useconds_t(Int.random(in: 500_000...2_000_000)))
        guard let characterData = CharactersMock().characters[characterID], let data = characterData else {
            return complete(.failure(NetworkError.noData))
        }
        complete(.success(data))
    }

}
