//
//  c.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 15/08/2021.
//

import Foundation

struct ComicSummaryViewModel {
    
    private let comicSummary: ComicSummary
    private let seriesTitle: String
    
    init(
        for comicSummary: ComicSummary,
        seriesTitle: String
    ) {
        self.comicSummary = comicSummary
        self.seriesTitle = seriesTitle
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
            return "\(seriesTitle)"
        }
        return "\(seriesTitle) #\(number)"
    }
    
}
