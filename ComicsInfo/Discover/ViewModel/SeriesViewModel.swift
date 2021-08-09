//
//  SeriesViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 20/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct SeriesViewModel: Codable {

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

//    /// A resource list containing characters ID which appear in comics in this series.
//    let charactersID: Set<String>

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

extension SeriesViewModel {

    init(from series: Series) {
        identifier = series.identifier
        popularity = series.popularity
        title = series.title
        thumbnail = series.thumbnail ?? ""
        description = series.description ?? ""
        startYear = series.startYear
        endYear = series.endYear
//        charactersID = series.charactersID
    }

}
