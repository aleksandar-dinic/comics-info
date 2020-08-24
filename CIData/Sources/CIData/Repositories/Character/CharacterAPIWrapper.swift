//
//  CharacterAPIWrapper.swift
//  CIData
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public struct CharacterAPIWrapper {

    private let characterAPIService: CharacterAPIService
    private let characterDecoderService: CharacterDecoderService

    init(
        characterAPIService: CharacterAPIService,
        characterDecoderService: CharacterDecoderService
    ) {
        self.characterAPIService = characterAPIService
        self.characterDecoderService = characterDecoderService
    }

    func getAllCharacters(
        onComplete complete: @escaping (Result<[Character], Error>) -> Void
    ) {
        characterAPIService.getAllCharacters { result in
            switch result {
            case let .success(data):
                let decodedResult = characterDecoderService.decodeAllCharacters(from: data)
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
                let decodedResult = characterDecoderService.decodeCharacter(from: data)
                complete(decodedResult.map({ Character(from: $0) }))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }

}
