//
//  c.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 15/08/2021.
//

import Foundation

struct ComicSummaryViewModel {
    
    private let comicSummary: ComicSummary
    private let seriesViewModel: SeriesViewModel
    
    init(
        for comicSummary: ComicSummary,
        seriesViewModel: SeriesViewModel
    ) {
        self.comicSummary = comicSummary
        self.seriesViewModel = seriesViewModel
//        popularity = comic.popularity
//        description = comic.description ?? ""
    }
    
    var title: String {
        "\"\(comicSummary.title)\""
    }
    
    var thumbnail: String {
        comicSummary.thumbnail ?? ""
    }
    
    var description: String {
        comicSummary.description ?? ""
    }
    
    var thumbnailSystemName: String {
        "photo.on.rectangle"
    }
    
    var publishedDate: String {
        guard let published = comicSummary.published else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, YYY"
        return "(\(formatter.string(from: published)))"
    }
    
    var issue: String {
        guard let number = comicSummary.number else {
            return "\(seriesViewModel.title)"
        }
        return "\(seriesViewModel.title) \"#\(number)\""
    }
    
}
