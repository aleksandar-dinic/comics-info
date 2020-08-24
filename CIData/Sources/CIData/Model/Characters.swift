//
//  Characters.swift
//  CIData
//
//  Created by Aleksandar Dinic on 21/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Character
import Foundation

public struct Character {

    /// The unique ID of the character resource.
    public let identifier: String

    /// The value of character popularity
    public let popularity: Int

    /// The name of the character.
    public let name: String

    /// The representative image for this character.
    public let thumbnail: String?

    ///  A short bio or description of the character
    public let description: String?

    public init(
        identifier: String,
        popularity: Int,
        name: String,
        thumbnail: String?,
        description: String?
    ) {
        self.identifier = identifier
        self.popularity = popularity
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
    }

}

extension Character {

    init(from character: Domain.Character) {
        identifier = character.identifier
        popularity = character.popularity
        name = character.name
        thumbnail = character.thumbnail
        description = character.description
    }

}
