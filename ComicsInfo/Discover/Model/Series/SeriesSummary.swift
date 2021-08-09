//
//  SeriesSummary.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/03/2021.
//

import struct Domain.ItemSummary
import Foundation

struct SeriesSummary: Codable, Hashable {
    
    /// The unique ID of the series resource.
    let identifier: String
    
    /// The value of series popularity.
    let popularity: Int
    
    /// The title of the series.
    let title: String
    
    /// The representative image for this series.
    let thumbnail: String?

    /// A short bio or description of the series.
    let description: String?

}

extension SeriesSummary {
    
    init(from summary: Domain.ItemSummary) {
        identifier = summary.identifier
        popularity = summary.popularity
        title = summary.name
        thumbnail = summary.thumbnail
        description = summary.description
    }
    
}

extension Domain.ItemSummary {
    
    init(from summary: SeriesSummary) {
        self.init(
            identifier: summary.identifier,
            popularity: summary.popularity,
            name: summary.title,
            thumbnail: summary.thumbnail,
            description: summary.description,
            count: nil,
            number: nil,
            roles: nil
        )
    }
    
}
