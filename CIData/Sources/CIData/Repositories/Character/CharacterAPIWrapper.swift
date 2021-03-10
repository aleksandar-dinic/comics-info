//
//  CharacterAPIWrapper.swift
//  CIData
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
import Foundation

public struct CharacterAPIWrapper: DecoderService {

    private let characterAPIService: CharacterAPIService

    init(characterAPIService: CharacterAPIService) {
        self.characterAPIService = characterAPIService
    }

    func getAllCharacters(
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        characterAPIService.getAllCharacters { result in
            switch result {
            case let .success(data):
                let decodedResult: Result<[Domain.Character], Error> = decode(from: data)
                complete(decodedResult.map({ $0.map({ Character(from: $0) }) }))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

    func getCharacter(
        withID characterID: String,
        onComplete complete: @escaping (Result<Character, Error>) -> Void
    ) {
        characterAPIService.getCharacter(withID: characterID) { result in
            switch result {
            case let .success(data):
                let decodedResult: Result<Domain.Character, Error> = decode(from: data)
                complete(decodedResult.map({ Character(from: $0) }))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

}
