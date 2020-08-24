//
//  Comic.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct ComicPresenter: Codable {

    /// The unique ID of the comic resource.
    let identifier: String

    /// The value of comic popularity
    let popularity: Int

    /// The canonical title of the comic.
    let title: String

    /// The representative image for this comics.
    let thumbnail: String

    /// The number of the issue in the series.
    let issueNumber: String

    /// The preferred description of the comic.
    let description: String

    /// The publication format of the comic e.g. comic, hardcover, trade paperback.
    let format: String?

    /// The Int of story pages in the comic.
    let pageCount: Int?

    /// A resource list containing series ID to which this comic belongs.
    let seriesID: Set<String>

    /// A resource list containing characters ID which appear in this comic.
    let charactersID: Set<String>

    /// The date of publication for this comic.
    let published: Date?

    /// The representative system image for this comic.
    var thumbnailSystemName: String {
        "photo.on.rectangle"
    }

    var issue: String {
        "#\(issueNumber)"
    }

    var publishedDate: String {
        guard let published = published else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, YYY"
        return formatter.string(from: published)
    }

}

extension ComicPresenter {

    init(from comic: Comic) {
        identifier = comic.identifier
        popularity = comic.popularity
        title = comic.title
        thumbnail = comic.thumbnail ?? ""
        issueNumber = comic.issueNumber ?? ""
        description = comic.description ?? ""
        format = comic.format
        pageCount = comic.pageCount
        seriesID = comic.seriesID
        charactersID = comic.charactersID
        published = comic.published
    }

}
