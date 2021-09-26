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
    private let seriesSummaryViewModel: SeriesSummaryViewModel

    init(
        from comic: Comic,
        seriesSummaryViewModel: SeriesSummaryViewModel
    ) {
        self.comic = comic
        self.seriesSummaryViewModel = seriesSummaryViewModel
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
            return "\(seriesSummaryViewModel.title)"
        }
        return "\(seriesSummaryViewModel.title) #\(number)"
    }

    var publishedDate: String {
        guard let published = comic.published else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, YYY"
        return formatter.string(from: published)
    }

}
