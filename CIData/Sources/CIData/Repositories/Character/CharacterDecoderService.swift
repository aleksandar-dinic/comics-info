//
//  CharacterDecoderService.swift
//  CIData
//
//  Created by Aleksandar Dinic on 21/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
import Foundation

public protocol CharacterDecoderService {

    func decodeAllCharacters(from data: Data) -> Result<[Domain.Character], Error>

    func decodeCharacter(from data: Data) -> Result<Domain.Character, Error>

}
