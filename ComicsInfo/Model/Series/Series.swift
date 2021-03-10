//
//  Series.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct CIData.Series
import struct CIData.CharacterSummary
import struct CIData.ComicSummary
import Foundation

struct Series: Codable {

    /// The unique ID of the series resource.
    let identifier: String

    /// The value of Series popularity.
    let popularity: Int

    /// The canonical title of the series.
    let title: String

    /// The representative image for this series.
    let thumbnail: String?

    /// A description of the series.
    let description: String?

    /// The first year of publication for the series.
    let startYear: Int?

    /// The last year of publication for the series (conventionally, nil for ongoing series).
    let endYear: Int?
    
    /// List of aliases the series is known by.
    let aliases: [String]?

    /// A resource list containing characters which appear in comics in this series.
    let characters: [CharacterSummary]?

    /// A resource list containing comics in this series.
    let comics: [ComicSummary]?

}

extension Series {

    init(from series: CIData.Series) {
        identifier = series.identifier
        popularity = series.popularity
        title = series.title
        thumbnail = series.thumbnail ?? ""
        description = series.description ?? ""
        startYear = series.startYear
        endYear = series.endYear
        aliases = series.aliases
        characters = series.characters?.map { CharacterSummary(from: $0) }
        comics = series.comics?.map { ComicSummary(from: $0) }
    }

}

extension CIData.Series {

    init(from series: Series) {
        self.init(
            identifier: series.identifier,
            popularity: series.popularity,
            title: series.title,
            thumbnail: series.thumbnail,
            description: series.thumbnail,
            startYear: series.startYear,
            endYear: series.endYear,
            aliases: series.aliases,
            characters: series.characters?.map { CIData.CharacterSummary(from: $0) },
            comics: series.comics?.map { CIData.ComicSummary(from: $0) }
        )
    }

}

extension Series: Hashable {

    static func == (lhs: Series, rhs: Series) -> Bool {
        lhs.identifier == rhs.identifier
    }

}

#if DEBUG
extension Series {
    
    static func make(
        identifier: String = "1",
        popularity: Int = 1,
        title: String = "The Flash",
        thumbnail: String? = "TheFlash",
        description: String? = """
            The Flash (Volume 1) is an ongoing series published by DC Comics. It has primarily starred Barry Allen, \
            the Silver Age Flash. The series was originally published for 246 issues from February/March of 1959 until \
            October 1985 (#105-#350). The numbering of the series picks up from Flash Comics, which ended with issue \
            #104 in 1949. In 2020, the series was revived with legacy numbering beginning with #750.
            """,
        startYear: Int? = nil,
        endYear: Int? = nil,
        aliases: [String]? = nil,
        characters: [CharacterSummary]? = nil,
        comics: [ComicSummary]? = nil
    ) -> Series {
        Series(
            identifier: identifier,
            popularity: popularity,
            title: title,
            thumbnail: thumbnail,
            description: thumbnail,
            startYear: startYear,
            endYear: endYear,
            aliases: aliases,
            characters: characters,
            comics: comics
        )
    }

}
#endif
