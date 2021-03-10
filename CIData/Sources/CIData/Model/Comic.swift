//
//  Comic.swift
//  CIData
//
//  Created by Aleksandar Dinic on 23/04/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
import Foundation

public struct Comic {

    /// The unique ID of the comic resource.
    public let identifier: String

    /// The value of comic popularity.
    public let popularity: Int

    /// The canonical title of the comic.
    public let title: String

    /// The representative image for this comics.
    public let thumbnail: String?

    /// The preferred description of the comic.
    public let description: String?

    /// The number of the comic in the series.
    public let number: String?
    
    /// List of aliases the comic is known by.
    public let aliases: [String]?

    /// The publication format of the comic e.g. comic, hardcover, trade paperback.
    public let format: String?

    /// The Int of story pages in the comic.
    public let pageCount: Int?

    /// The date of publication for this comic.
    public let published: Date?

    /// A resource list containing the characters which appear in this comic.
    public let characters: [CharacterSummary]?

    /// A resource list containing the series in which this comic appears.
    public let series: [SeriesSummary]?

    public init(
        identifier: String,
        popularity: Int,
        title: String,
        thumbnail: String?,
        description: String?,
        number: String?,
        aliases: [String]?,
        format: String?,
        pageCount: Int?,
        published: Date?,
        characters: [CharacterSummary]?,
        series: [SeriesSummary]?
    ) {
        self.identifier = identifier
        self.popularity = popularity
        self.title = title
        self.thumbnail = thumbnail
        self.description = description
        self.number = number
        self.aliases = aliases
        self.format = format
        self.pageCount = pageCount
        self.published = published
        self.characters = characters
        self.series = series
    }

}

extension Comic {

    init(from comic: Domain.Comic) {
        identifier = comic.identifier
        popularity = comic.popularity
        title = comic.title
        thumbnail = comic.thumbnail
        number = comic.number
        aliases = comic.aliases
        description = comic.description
        format = comic.format
        pageCount = comic.pageCount
        characters = comic.characters?.map { CharacterSummary(from: $0) }
        series = comic.series?.map { SeriesSummary(from: $0) }
        published = comic.published
    }

}
