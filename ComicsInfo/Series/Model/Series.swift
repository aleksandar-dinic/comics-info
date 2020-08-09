//
//  Series.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Series
import Foundation

struct Series {

    /// The unique ID of the series resource.
    let identifier: String

    /// The value of Series popularity
    let popularity: Int

    /// The canonical title of the series.
    let title: String

    /// The representative image for this series.
    let thumbnail: String

    /// A description of the series.
    let description: String

    /// The first year of publication for the series.
    let startYear: Int?

    /// The last year of publication for the series (conventionally, nil for ongoing series) .
    let endYear: Int?

    /// A resource list containing characters ID which appear in comics in this series.
    let charactersID: Set<String>

    /// The representative system image for this character.
    var thumbnailSystemName: String {
        "photo.on.rectangle"
    }

    var startAndEndYer: String {
        if let startYear = startYear, let endYear = endYear {
            return "(\(startYear) - \(endYear))"
        } else if let startYear = startYear {
            return "(\(startYear) - ...)"
        } else if let endYear = endYear {
            return "(???? - \(endYear))"
        }

        return "(???? - ????)"
    }

}

extension Series {

    init(from series: Domain.Series) {
        identifier = series.identifier
        popularity = series.popularity
        title = series.title
        thumbnail = series.thumbnail ?? ""
        description = series.description ?? ""
        startYear = series.startYear
        endYear = series.endYear
        charactersID = series.charactersID
    }

}

extension Series: Hashable {

    static func == (lhs: Series, rhs: Series) -> Bool {
        lhs.identifier == rhs.identifier
    }

}

#if DEBUG
extension Series {

    // Flash

    static let theFlash = Series(
        identifier: "1",
        popularity: 1,
        title: "The Flash",
        thumbnail: "TheFlash",
        description: """
            The Flash (Volume 1) is an ongoing series published by DC Comics. It has primarily starred Barry Allen, \
            the Silver Age Flash. The series was originally published for 246 issues from February/March of 1959 until \
            October 1985 (#105-#350). The numbering of the series picks up from Flash Comics, which ended with issue \
            #104 in 1949. In 2020, the series was revived with legacy numbering beginning with #750.
            """,
        startYear: 1959,
        endYear: 1985,
        charactersID: ["1"]
    )

    static let theFlashVol2  = Series(
        identifier: "2",
        popularity: 2,
        title: "The Flash Vol 2",
        thumbnail: "",
        description: """
            The Flash (Volume 2) is an ongoing series that focuses on the adventures of the third Flash, \
            Wally West. It ran 233 issues (Counting "#0," "#1/2," and "#1,000,000") from June 1987 through \
            March 2006. During "One Year Later," it ended and made way for a new Flash series, The Flash: The \
            Fastest Man Alive, which starred Wally's successor, Bart Allen. The Fastest Man Alive however, ended \
            after a one year run, and as of issue #231 in 2007, The Flash (Volume 2) resumed publication. It ended \
            in February 2009 with issue #247. The Flash Vol 3 began publication in 2010.
            """,
        startYear: 1959,
        endYear: 1985,
        charactersID: ["1"]
    )

    static let theFlashVol3 = Series(
        identifier: "3",
        popularity: 3,
        title: "The Flash Vol 3",
        thumbnail: "",
        description: """
            The Flash (Volume 3) was an ongoing series, published by DC Comics. It ran from 2010 until 2011. \
            It starred Flash.
            """,
        startYear: 1959,
        endYear: 1985,
        charactersID: ["1"]
    )

    // Spider-Man

    static let amazingSpiderMan = Series(
        identifier: "4",
        popularity: 1,
        title: "Amazing Spider-Man",
        thumbnail: "",
        description: """
            The Amazing Spider-Man is an American comic book series published by Marvel Comics, featuring the \
            fictional superher Spider-Man as its main protagonist.
            """,
        startYear: 1963,
        endYear: 2018,
        charactersID: ["2"]
    )

    static let peterParkerTheSpectacularSpiderMan = Series(
        identifier: "5",
        popularity: 2,
        title: "Peter Parker, The Spectacular Spider-Man",
        thumbnail: "",
        description: """
            The Spectacular Spider-Man is a comic book and magazine series starring Spider-Man and published \
            by Marvel Comics.
            """,
        startYear: 1976,
        endYear: 1987,
        charactersID: ["2"]
    )

    static let webOfSpiderMan = Series(
        identifier: "6",
        popularity: 3,
        title: "Web of Spider-Man",
        thumbnail: "",
        description: """
            Web of Spider-Man is the name of two different monthly comic book series starring Spider-Man that \
            have been published by Marvel Comics since 1985, the first volume of which ran for 129 issues \
            between 1985 and 1995, and the second of which ran for 12 issues between 2009 and 2010.
            """,
        startYear: 1985,
        endYear: 2012,
        charactersID: ["2"]
    )

    static let theSpectacularSpiderMan = Series(
        identifier: "7",
        popularity: 4,
        title: "The Spectacular Spider-Man",
        thumbnail: "",
        description: """
            The Spectacular Spider-Man is a comic book and magazine series starring Spider-Man and published \
            by Marvel Comics.
            """,
        startYear: 1988,
        endYear: 1998,
        charactersID: ["2"]
    )

    static let amazingSpiderManVol5 = Series(
        identifier: "8",
        popularity: 5,
        title: "Amazing Spider-Man Vol 5",
        thumbnail: "",
        description: """
            The Amazing Spider-Man is an American comic book series published by Marvel Comics, featuring \
            the fictional superhero Spider-Man as its main protagonist.
            """,
        startYear: 2018,
        endYear: nil,
        charactersID: ["2"]
    )

}
#endif
