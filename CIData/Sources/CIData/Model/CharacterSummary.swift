//
//  CharacterSummary.swift
//  CIData
//
//  Created by Aleksandar Dinic on 18/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import struct Domain.ItemSummary
import Foundation

public struct CharacterSummary {
    
    /// The unique ID of the item resource.
    public let identifier: String
    
    /// The value of item popularity.
    public let popularity: Int
    
    /// The name of the item.
    public let name: String
    
    /// The representative image for this item.
    public let thumbnail: String?

    /// A short bio or description of the item.
    public let description: String?
    
    /// The number of appearance of this item.
    public let count: Int?
    
    public init(
        identifier: String,
        popularity: Int,
        name: String,
        thumbnail: String?,
        description: String?,
        count: Int?
    ) {
        self.identifier = identifier
        self.popularity = popularity
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
        self.count = count
    }
    
}

extension CharacterSummary {
    
    init(from summary: Domain.ItemSummary) {
        identifier = summary.identifier
        popularity = summary.popularity
        name = summary.name
        thumbnail = summary.thumbnail
        description = summary.description
        count = summary.count
    }
    
}
