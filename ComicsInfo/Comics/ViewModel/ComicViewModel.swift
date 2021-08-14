//
//  ComicViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct ComicViewModel: Codable {

    /// The unique ID of the comic resource.
    let identifier: String

    /// The value of comic popularity
    let popularity: Int

    /// The canonical title of the comic.
    let title: String

    /// The representative image for this comics.
    let thumbnail: String

    /// The number of the comic in the series.
    let number: String

    /// The preferred description of the comic.
    let description: String

    /// The publication format of the comic e.g. comic, hardcover, trade paperback.
    let format: String?

    /// The Int of story pages in the comic.
    let pageCount: Int?

//    /// A resource list containing series ID to which this comic belongs.
//    let seriesID: Set<String>
//
//    /// A resource list containing characters ID which appear in this comic.
//    let charactersID: Set<String>

    /// The date of publication for this comic.
    let published: Date?

    /// The representative system image for this comic.
    var thumbnailSystemName: String {
        "photo.on.rectangle"
    }

    var issue: String {
        "#\(number)"
    }

    var publishedDate: String {
        guard let published = published else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, YYY"
        return formatter.string(from: published)
    }

}

extension ComicViewModel {

    init(from comic: Comic) {
        identifier = comic.identifier
        popularity = comic.popularity
        title = comic.title
        thumbnail = comic.thumbnail ?? ""
        number = comic.number ?? ""
        description = comic.description ?? ""
        format = comic.format
        pageCount = comic.pageCount
//        series = comic.series
//        characters = comic.characters
        published = comic.published
    }

    init(from comic: ComicSummary) {
        identifier = comic.identifier
        popularity = comic.popularity
        title = comic.title
        thumbnail = comic.thumbnail ?? ""
        number = comic.number ?? ""
        description = comic.description ?? ""
        format = nil
        pageCount = nil
//        series = comic.series
//        characters = comic.characters
        published = nil
    }
    
}
