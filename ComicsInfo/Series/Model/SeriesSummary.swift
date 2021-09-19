//
//  SeriesSummary.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/03/2021.
//

import struct Domain.SeriesSummary
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
    
    /// The first year of publication for the series.
    let startYear: Int?

    /// The last year of publication for the series (conventionally, nil for ongoing series).
    let endYear: Int?

}

extension SeriesSummary: Comparable {
    
    static func < (lhs: SeriesSummary, rhs: SeriesSummary) -> Bool {
        guard lhs.popularity != rhs.popularity else {
            return lhs.title < rhs.title
        }
        
        return abs(lhs.popularity - 100) < abs(rhs.popularity - 100)
    }
    
}

extension SeriesSummary {
    
    init(from summary: Domain.SeriesSummary) {
        identifier = summary.identifier
        popularity = summary.popularity
        title = summary.title
        thumbnail = summary.thumbnail
        description = summary.description
        startYear = summary.startYear
        endYear = summary.endYear
    }
    
}

extension Domain.SeriesSummary {
    
    init(from summary: SeriesSummary) {
        self.init(
            identifier: summary.identifier,
            popularity: summary.popularity,
            title: summary.title,
            thumbnail: summary.thumbnail,
            description: summary.description,
            startYear: summary.startYear,
            endYear: summary.endYear
        )
    }
    
}

#if DEBUG
extension SeriesSummary {
    
    static func make(
        identifier: String = "1",
        popularity: Int = 0,
        title: String = "Series Summary Title",
        thumbnail: String? = nil,
        description: String? = nil,
        startYear: Int? = nil,
        endYear: Int? = nil
    ) -> SeriesSummary {
        SeriesSummary(
            identifier: identifier,
            popularity: popularity,
            title: title,
            thumbnail: thumbnail,
            description: description,
            startYear: startYear,
            endYear: endYear
        )
    }

}
#endif
