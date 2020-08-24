//
//  Comic.swift
//  CIData
//
//  Created by Aleksandar Dinic on 23/04/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Comic
import Foundation

public struct Comic {

    /// The unique ID of the comic resource.
    public let identifier: String

    /// The value of comic popularity
    public let popularity: Int

    /// The canonical title of the comic.
    public let title: String

    /// The representative image for this comics.
    public let thumbnail: String?

    /// The number of the issue in the series.
    public let issueNumber: String?

    /// The preferred description of the comic.
    public let description: String?

    /// The publication format of the comic e.g. comic, hardcover, trade paperback.
    public let format: String?

    /// The Int of story pages in the comic.
    public let pageCount: Int?

    /// A resource list containing series ID to which this comic belongs.
    public let seriesID: Set<String>

    /// A resource list containing characters ID which appear in this comic.
    public let charactersID: Set<String>

    /// The date of publication for this comic.
    public let published: Date?

    public init(
        identifier: String,
        popularity: Int,
        title: String,
        thumbnail: String?,
        issueNumber: String?,
        description: String?,
        format: String?,
        pageCount: Int?,
        seriesID: Set<String>,
        charactersID: Set<String>,
        published: Date?
    ) {
        self.identifier = identifier
        self.popularity = popularity
        self.title = title
        self.thumbnail = thumbnail
        self.issueNumber = issueNumber
        self.description = description
        self.format = format
        self.pageCount = pageCount
        self.seriesID = seriesID
        self.charactersID = charactersID
        self.published = published
    }

}

extension Comic {

    init(from comic: Domain.Comic) {
        identifier = comic.identifier
        popularity = comic.popularity
        title = comic.title
        thumbnail = comic.thumbnail
        issueNumber = comic.issueNumber
        description = comic.description
        format = comic.format
        pageCount = comic.pageCount
        seriesID = comic.seriesID
        charactersID = comic.charactersID
        published = comic.published
    }

}
