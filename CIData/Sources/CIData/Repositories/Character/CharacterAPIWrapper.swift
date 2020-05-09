//
//  CharacterAPIWrapper.swift
//  CIData
//
//  Created by Aleksandar Dinic on 08/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
import Foundation

struct CharacterAPIWrapper {

    private let characterAPIService: CharacterAPIService

    init(characterAPIService: CharacterAPIService) {
        self.characterAPIService = characterAPIService
    }

    func getCharacters(
        onComplete complete: @escaping (Result<[Domain.Character], Error>) -> Void
    ) {
        characterAPIService.getCharacters { result in
            complete(self.decodeResult(result))
        }
    }

    func getCharacter(
        withID characterID: String,
        onComplete complete: @escaping (Result<Domain.Character, Error>) -> Void
    ) {
        characterAPIService.getCharacter(withID: characterID) { result in
            complete(self.decodeResult(result))
        }
    }

}

extension CharacterAPIWrapper {

    private func decodeResult<T: Codable>(_ result: Result<Data, Error>) -> Result<T, Error> {
        switch result {
        case let .success(data):

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .millisecondsSince1970

            do {
                let response = try decoder.decode(T.self, from: data)
                return .success(response)

            } catch {
                return .failure(error)
            }

        case let .failure(error):
            return .failure(error)
        }
    }

}
