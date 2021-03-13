//
//  Comic.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
import struct Domain.ItemSummary
import Foundation

struct Comic: Codable {

    /// The unique ID of the comic resource.
    let identifier: String

    /// The value of comic popularity.
    let popularity: Int

    /// The canonical title of the comic.
    let title: String

    /// The representative image for this comics.
    let thumbnail: String?

    /// The preferred description of the comic.
    let description: String?

    /// The number of the comic in the series.
    let number: String?
    
    /// List of aliases the comic is known by.
    let aliases: [String]?

    /// The publication format of the comic e.g. comic, hardcover, trade paperback.
    let format: String?

    /// The Int of story pages in the comic.
    let pageCount: Int?

    /// The date of publication for this comic.
    let published: Date?

    /// A resource list containing the characters which appear in this comic.
    let characters: [CharacterSummary]?

    /// A resource list containing the series in which this comic appears.
    let series: [SeriesSummary]?
    
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
        published = comic.published
        characters = comic.characters?.map { CharacterSummary(from: $0) }
        series = comic.series?.map { SeriesSummary(from: $0) }
    }

}

extension Comic: Hashable {

    static func == (lhs: Comic, rhs: Comic) -> Bool {
        lhs.identifier == rhs.identifier
    }

}

extension Domain.Comic {

    init(from comic: Comic) {
        self.init(
            identifier: comic.identifier,
            popularity: comic.popularity,
            title: comic.title,
            thumbnail: comic.thumbnail,
            description: comic.description,
            number: comic.number,
            aliases: comic.aliases,
            variantDescription: nil,
            format: comic.format,
            pageCount: comic.pageCount,
            variantsIdentifier: nil,
            collectionsIdentifier: nil,
            collectedIdentifiers: nil,
            images: nil,
            published: comic.published,
            characters: comic.characters?.map { Domain.ItemSummary(from: $0) },
            series: comic.series?.map { Domain.ItemSummary(from: $0) }
        )
    }

}

#if DEBUG
extension Comic {
    
    static func make(
        identifier: String = "1",
        popularity: Int = 1,
        title: String = "Spider-Man",
        thumbnail: String? = "AmazingSpiderMan1",
        description: String? = """
            With the Parker household desperate for money following the death of Ben Parker, Peter Parker \
            decides to continue in show business as Spider-Man. However, not only does he find it impossible \
            to cash his paycheck (made out to Spider-Man), but the irrational editorials by J. Jonah Jameson \
            in the Daily Bugle effectively quelch his career. Besides denouncing Spider-Man as a \
            publicity-seeking phony, J. Jonah Jameson also publishes articles lauding his son, John Jameson, \
            a courageous astronaut about to be launched into orbit in a space capsule. J. Jonah Jameson calls \
            his son a "real hero."
            """,
        number: String? = "1",
        aliases: [String]? = nil,
        format: String? = nil,
        pageCount: Int? = nil,
        published: Date? = nil,
        characters: [CharacterSummary]? = nil,
        series: [SeriesSummary]? = nil
    ) -> Comic {
        Comic(
            identifier: identifier,
            popularity: popularity,
            title: title,
            thumbnail: thumbnail,
            description: description,
            number: number,
            aliases: aliases,
            format: format,
            pageCount: pageCount,
            published: published,
            characters: characters,
            series: series
        )
    }

}
#endif
