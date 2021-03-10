//
//  Series.swift
//  CIData
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
import Foundation

public struct Series {

    /// The unique ID of the series resource.
    public let identifier: String

    /// The value of Series popularity.
    public let popularity: Int

    /// The canonical title of the series.
    public let title: String

    /// The representative image for this series.
    public let thumbnail: String?

    /// A description of the series.
    public let description: String?

    /// The first year of publication for the series.
    public let startYear: Int?

    /// The last year of publication for the series (conventionally, nil for ongoing series).
    public let endYear: Int?
    
    /// List of aliases the series is known by.
    public let aliases: [String]?

    /// A resource list containing characters which appear in comics in this series.
    public let characters: [CharacterSummary]?

    /// A resource list containing comics in this series.
    public let comics: [ComicSummary]?

    public init(
        identifier: String,
        popularity: Int,
        title: String,
        thumbnail: String?,
        description: String?,
        startYear: Int?,
        endYear: Int?,
        aliases: [String]?,
        characters: [CharacterSummary]?,
        comics: [ComicSummary]?
    ) {
        self.identifier = identifier
        self.popularity = popularity
        self.title = title
        self.thumbnail = thumbnail
        self.description = description
        self.startYear = startYear
        self.endYear = endYear
        self.aliases = aliases
        self.characters = characters
        self.comics = comics
    }

}

extension Series {

    init(from series: Domain.Series) {
        identifier = series.identifier
        popularity = series.popularity
        title = series.title
        thumbnail = series.thumbnail
        description = series.description
        startYear = series.startYear
        endYear = series.endYear
        aliases = series.aliases
        characters = series.characters?.map { CharacterSummary(from: $0) }
        comics = series.comics?.map { ComicSummary(from: $0) }
    }

}
