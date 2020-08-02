//
//  CharacterCacheService.swift
//  CIData
//
//  Created by Aleksandar Dinic on 09/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
import Foundation

public protocol CharacterCacheService {

    func getAllCharacters() -> [Domain.Character]?

    func getCharacter(withID characterID: String) -> Domain.Character?

    func save(characters: [Domain.Character])

}
