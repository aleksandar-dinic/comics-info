//
//  CharacterAPIService.swift
//  CIData
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public protocol CharacterAPIService {

    func getCharacters(
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )

    func getCharacter(
        withID characterID: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )

}
