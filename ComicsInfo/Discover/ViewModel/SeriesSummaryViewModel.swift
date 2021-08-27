//
//  SeriesSummaryViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct SeriesSummaryViewModel: Codable {
    
    private let seriesSummary: SeriesSummary

    init(from seriesSummary: SeriesSummary) {
        self.seriesSummary = seriesSummary
    }
    
    var identifier: String {
        seriesSummary.identifier
    }
    
    var title: String {
        "\(seriesSummary.title)"
    }
    
    var thumbnail: String {
        seriesSummary.thumbnail ?? ""
    }

    var thumbnailSystemName: String {
        "photo.on.rectangle"
    }

    var startYear: Int? {
        seriesSummary.startYear
    }

    var endYear: Int? {
        seriesSummary.endYear
    }

    var startAndEndYer: String {
        if let startYear = startYear, let endYear = endYear {
            return "(\(startYear) - \(endYear))"
        } else if let startYear = startYear {
            return "(\(startYear) - Present)"
        } else if let endYear = endYear {
            return "(???? - \(endYear))"
        }

        return "(???? - Present)"
    }

}
