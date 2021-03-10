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

    /// The value of character popularity.
    public let popularity: Int

    /// The name of the character.
    public let name: String

    /// The representative image for this character.
    public let thumbnail: String?

    /// A short bio or description of the character.
    public let description: String?
    
    /// Real name of the character.
    public let realName: String?
    
    /// List of aliases the character is known by.
    public let aliases: [String]?
    
    /// A date, that the character was born on. Not an origin date.
    public let birth: Date?

    /// A resource list of series in which this character appears.
    public let series: [SeriesSummary]?

    /// A resource list containing comics which feature this character.
    public let comics: [ComicSummary]?

    public init(
        identifier: String,
        popularity: Int,
        name: String,
        thumbnail: String?,
        description: String?,
        realName: String?,
        aliases: [String]?,
        birth: Date?,
        series: [SeriesSummary]?,
        comics: [ComicSummary]?
    ) {
        self.identifier = identifier
        self.popularity = popularity
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
        self.realName = realName
        self.aliases = aliases
        self.birth = birth
        self.series = series
        self.comics = comics
    }

}

extension Character {

    init(from character: Domain.Character) {
        identifier = character.identifier
        popularity = character.popularity
        name = character.name
        thumbnail = character.thumbnail
        description = character.description
        realName = character.realName
        aliases = character.aliases
        birth = character.birth
        series = character.series?.map { SeriesSummary(from: $0) }
        comics = character.comics?.map { ComicSummary(from: $0) }
    }

}
