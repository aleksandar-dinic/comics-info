//
//  CharacterSummary.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/03/2021.
//

import struct CIData.CharacterSummary
import Foundation

struct CharacterSummary: Codable, Hashable {
    
    /// The unique ID of the character resource.
    let identifier: String
    
    /// The value of character popularity.
    let popularity: Int
    
    /// The name of the character.
    let name: String
    
    /// The representative image for this character.
    let thumbnail: String?

    /// A short bio or description of the character.
    let description: String?
    
    /// The number of appearance of this character.
    let count: Int?

}

extension CharacterSummary {
    
    init(from summary: CIData.CharacterSummary) {
        identifier = summary.identifier
        popularity = summary.popularity
        name = summary.name
        thumbnail = summary.thumbnail
        description = summary.description
        count = summary.count
    }
    
}

extension CIData.CharacterSummary {
    
    init(from summary: CharacterSummary) {
        self.init(
            identifier: summary.identifier,
            popularity: summary.popularity,
            name: summary.name,
            thumbnail: summary.thumbnail,
            description: summary.description,
            count: summary.count
        )
    }
    
}
