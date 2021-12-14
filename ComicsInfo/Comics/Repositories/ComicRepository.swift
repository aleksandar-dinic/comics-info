//
//  ComicRepository.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol ComicRepository {

    var comicDataProvider: ComicDataProvider { get }

    init(comicDataProvider: ComicDataProvider)

    func getComicSummaries(
        for seriesID: String,
        afterID: String?,
        limit: Int,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[ComicSummary], Error>) -> Void
    )
    
    func getComic(
        withID comicID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Comic, Error>) -> Void
    )
    
    func getMyComics(forSeriesID seriesID: String) -> [ComicSummary]?
    func addToMyComics(
        _ comicSummary: ComicSummary,
        character: Character,
        seriesSummary: SeriesSummary
    )
    func isInMyComics(
        _ comicID: String,
        forSeriesID seriesID: String
    ) -> Bool
    
    func getBookmarkComics() -> [Comic]?
    func addToBookmark(_ comicID: String)
    func removeFromBookmark(_ comicID: String)
    func isBookmarked(withID comicID: String) -> Bool

}
