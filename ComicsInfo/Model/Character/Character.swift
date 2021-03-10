//
//  Character.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct CIData.Character
import struct CIData.Series
import struct CIData.SeriesSummary
import struct CIData.ComicSummary
import Foundation

struct Character: Codable {

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
    
    /// Real name of the character.
    let realName: String?
    
    /// List of aliases the character is known by.
    let aliases: [String]?
    
    /// A date, that the character was born on. Not an origin date.
    let birth: Date?

    /// A resource list of series in which this character appears.
    let series: [SeriesSummary]?

    /// A resource list containing comics which feature this character.
    let comics: [ComicSummary]?

}

extension Character {

    init(from character: CIData.Character) {
        identifier = character.identifier
        popularity = character.popularity
        name = character.name
        thumbnail = character.thumbnail
        description = character.description
        realName = character.realName
        aliases = character.aliases
        birth = character.birth
        series = character.series?.map { SeriesSummary(from: $0) }
        comics = character.comics?.map { ComicSummary(from: $0) }
    }

}

extension CIData.Character {

    init(from character: Character) {
        self.init(
            identifier: character.identifier,
            popularity: character.popularity,
            name: character.name,
            thumbnail: character.thumbnail,
            description: character.description,
            realName: character.realName,
            aliases: character.aliases,
            birth: character.birth,
            series: character.series?.map { CIData.SeriesSummary(from: $0) },
            comics: character.comics?.map { CIData.ComicSummary(from: $0) }
        )
    }

}

extension Character: Hashable {

    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.identifier == rhs.identifier
    }

}

#if DEBUG
extension Character {

    static func make(
        identifier: String = "1",
        popularity: Int = 1,
        name: String = "Spider-Man",
        thumbnail: String? = "SpiderMan",
        description: String? = """
            Bitten by a radioactive spider, high school student Peter Parker gained the speed, \
            strength and powers of a spider. Adopting the name Spider-Man, Peter hoped to start a career using his \
            new abilities. Taught that with great power comes great responsibility, Spidey has vowed to use his powers \
            to help people.
            """,
        realName: String? = "Peter Parker",
        aliases: [String]? = nil,
        birth: Date? = nil,
        series: [SeriesSummary]? = nil,
        comics: [ComicSummary]? = nil
    ) -> Character {
        Character(
            identifier: identifier,
            popularity: popularity,
            name: name,
            thumbnail: thumbnail,
            description: description,
            realName: realName,
            aliases: aliases,
            birth: birth,
            series: series,
            comics: comics
        )
    }

}
#endif
