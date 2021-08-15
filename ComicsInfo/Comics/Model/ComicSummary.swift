//
//  ComicSummary.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/03/2021.
//

import struct Domain.ItemSummary
import Foundation

struct ComicSummary: Codable, Hashable {
    
    /// The unique ID of the comic resource.
    let identifier: String
    
    /// The value of comic popularity.
    let popularity: Int
    
    /// The title of the comic.
    let title: String
    
    /// The representative image for this comic.
    let thumbnail: String?

    /// A short bio or description of the comic.
    let description: String?
    
    /// The number of this comic.
    let number: String?
    
    /// The date of publication for this comic.
    let published: Date?

}

extension ComicSummary {
    
    init(from summary: Domain.ItemSummary) {
        identifier = summary.identifier
        popularity = summary.popularity
        title = summary.name
        thumbnail = summary.thumbnail
        description = summary.description
        number = summary.number
        published = nil //summary.published
    }
    
}

extension Domain.ItemSummary {
    
    init(from summary: ComicSummary) {
        self.init(
            identifier: summary.identifier,
            popularity: summary.popularity,
            name: summary.title,
            thumbnail: summary.thumbnail,
            description: summary.description,
            count: nil,
            number: summary.number,
            roles: nil
        )
    }
    
}

#if DEBUG
extension ComicSummary {
    
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
        published: Date? = Date()
    ) -> ComicSummary {
        ComicSummary(
            identifier: identifier,
            popularity: popularity,
            title: title,
            thumbnail: thumbnail,
            description: description,
            number: number,
            published: published
        )
    }

}
#endif
