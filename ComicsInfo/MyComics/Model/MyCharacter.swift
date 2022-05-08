//
//  MyCharacter.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 2/1/22.
//

import struct Domain.MyCharacter
import Foundation

struct MyCharacter: Codable {

    let identifier: String
    let popularity: Int
    let name: String
    let thumbnail: String?
    let description: String?
    let realName: String?
    let aliases: [String]?
    let birth: Date?
    var mySeries: [SeriesSummary]?
    
    mutating func removeMySeries(withID seriesID: String) {
        guard let index = mySeries?.firstIndex(where: { $0.identifier == seriesID }) else { return }
        mySeries?.remove(at: index)
    }
    
}

extension MyCharacter: Comparable {
    
    static func < (lhs: MyCharacter, rhs: MyCharacter) -> Bool {
        guard lhs.popularity != rhs.popularity else {
            return lhs.name < rhs.name
        }
        
        return abs(lhs.popularity - 100) < abs(rhs.popularity - 100)
    }
    
}

extension MyCharacter {

    init(from character: Character, mySeries: [SeriesSummary]? = nil) {
        identifier = character.identifier
        popularity = character.popularity
        name = character.name
        thumbnail = character.thumbnail
        description = character.description
        realName = character.realName
        aliases = character.aliases
        birth = character.birth
        self.mySeries = mySeries
    }

}

extension MyCharacter {

    init(from myCharacter: Domain.MyCharacter) {
        identifier = myCharacter.identifier
        popularity = myCharacter.popularity
        name = myCharacter.name
        thumbnail = myCharacter.thumbnail
        description = myCharacter.description
        realName = myCharacter.realName
        aliases = myCharacter.aliases
        birth = myCharacter.birth
        mySeries = myCharacter.mySeries?.map { SeriesSummary(from: $0) }.sorted()
    }

}
