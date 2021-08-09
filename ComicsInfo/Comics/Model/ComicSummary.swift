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

}

extension ComicSummary {
    
    init(from summary: Domain.ItemSummary) {
        identifier = summary.identifier
        popularity = summary.popularity
        title = summary.name
        thumbnail = summary.thumbnail
        description = summary.description
        number = summary.number
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
