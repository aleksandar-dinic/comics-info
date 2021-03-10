//
//  SeriesSummary.swift
//  CIData
//
//  Created by Aleksandar Dinic on 18/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import struct Domain.ItemSummary
import Foundation

public struct SeriesSummary {
    
    /// The unique ID of the item resource.
    public let identifier: String
    
    /// The value of item popularity.
    public let popularity: Int
    
    /// The name of the item.
    public let title: String
    
    /// The representative image for this item.
    public let thumbnail: String?

    /// A short bio or description of the item.
    public let description: String?
    
    public init(
        identifier: String,
        popularity: Int,
        title: String,
        thumbnail: String?,
        description: String?
    ) {
        self.identifier = identifier
        self.popularity = popularity
        self.title = title
        self.thumbnail = thumbnail
        self.description = description
    }
    
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
