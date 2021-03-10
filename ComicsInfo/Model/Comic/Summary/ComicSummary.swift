//
//  ComicSummary.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/03/2021.
//

import struct CIData.ComicSummary
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
    
    init(from summary: CIData.ComicSummary) {
        identifier = summary.identifier
        popularity = summary.popularity
        title = summary.title
        thumbnail = summary.thumbnail
        description = summary.description
        number = summary.number
    }
    
}

extension CIData.ComicSummary {
    
    init(from summary: ComicSummary) {
        self.init(
            identifier: summary.identifier,
            popularity: summary.popularity,
            title: summary.title,
            thumbnail: summary.thumbnail,
            description: summary.description,
            number: summary.number
        )
    }
    
}
