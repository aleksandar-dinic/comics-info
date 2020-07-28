//
//  Comic.swift
//  Domain
//
//  Created by Aleksandar Dinic on 23/04/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

public struct Comic: Codable {

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

    /// If the issue is a variant (e.g. an alternate cover, second printing, or director’s cut),
    /// a text description of the variant.
    public let variantDescription: String?

    /// The publication format of the comic e.g. comic, hardcover, trade paperback.
    public let format: String?

    /// The Int of story pages in the comic.
    public let pageCount: Int?

    /// A list of variant issues ID for this comic (includes the "original" issue if the current
    /// issue is a variant).
    public let variantsIdentifier: [String]?

    /// A list of collections ID which include this comic (will generally be nil if the comic's
    /// format is a collection).
    public let collectionsIdentifier: [String]?

    /// A list of issues ID collected in this comic (will generally be nil for periodical formats
    /// such as "comic" or "magazine").
    public let collectedIssuesIdentifier: [String]?

    /// A list of promotional images associated with this comic.
    public let images: [String]?

    /// A resource list containing series ID to which this comic belongs.
    public let seriesID: Set<String>

    /// A resource list containing characters ID which appear in this comic.
    public let charactersID: Set<String>

    /// The date of publication for this comic.
    public let published: Date?

}
