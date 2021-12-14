//
//  ComicViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct ComicViewModel: Codable {
    
    private let comic: Comic
    private let seriesSummary: SeriesSummary

    init(
        from comic: Comic,
        seriesSummary: SeriesSummary
    ) {
        self.comic = comic
        self.seriesSummary = seriesSummary
    }
    
    var identifier: String {
        comic.identifier
    }
    
    var title: String {
        "\"\(comic.title)\""
    }
    
    var thumbnail: String {
        comic.thumbnail ?? ""
    }
    
    var thumbnailSystemName: String {
        "photo.on.rectangle"
    }
    
    var description: String {
        comic.description ?? ""
    }
    
    var issue: String {
        guard let number = comic.number else {
            return seriesSummaryTitle
        }
        return "\(seriesSummaryTitle) #\(number)"
    }
    
    private var seriesSummaryTitle: String {
        "\(seriesSummary.title)"
    }

    var publishedDate: String {
        guard let published = comic.published else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, YYY"
        return formatter.string(from: published)
    }

}
