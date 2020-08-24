//
//  CharacterDecoderProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
import protocol CIData.CharacterDecoderService
import Foundation

public struct CharacterDecoderProvider: CIData.CharacterDecoderService {

    public func decodeAllCharacters(from data: Data) -> Result<[Domain.Character], Error> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970

        do {
            let characters = try decoder.decode([Domain.Character].self, from: data)
            return .success(characters)

        } catch {
            return .failure(error)
        }
    }

    public func decodeCharacter(from data: Data) -> Result<Domain.Character, Error> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970

        do {
            let character = try decoder.decode(Domain.Character.self, from: data)
            return .success(character)

        } catch {
            return .failure(error)
        }
    }

}
