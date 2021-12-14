//
//  ComicDataRepository.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class ComicDataRepository: ComicRepository {

    var comicDataProvider: ComicDataProvider

    init(comicDataProvider: ComicDataProvider) {
        self.comicDataProvider = comicDataProvider
    }

    func getComicSummaries(
        for seriesID: String,
        afterID: String?,
        limit: Int,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[ComicSummary], Error>) -> Void
    ) {
        comicDataProvider.getComicSummaries(
            for: seriesID,
            afterID: afterID,
            limit: limit,
            fromDataSource: dataSource,
            onComplete: complete
        )
    }
    
    func getComic(
        withID comicID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Comic, Error>) -> Void
    ) {
        comicDataProvider.getComic(
            withID: comicID,
            fromDataSource: dataSource,
            onComplete: complete
        )
    }
    
    // My Comics
    
    func getMyComics(forSeriesID seriesID: String) -> [ComicSummary]? {
        comicDataProvider.getMyComics(forSeriesID: seriesID)
    }

    func addToMyComics(
        _ comicSummary: ComicSummary,
        character: Character,
        seriesSummary: SeriesSummary
    ) {
        comicDataProvider.addInMyComics(
            comicSummary,
            character: character,
            seriesSummary: seriesSummary
        )
    }
    
    func isInMyComics(_ comicID: String, forSeriesID seriesID: String) -> Bool {
        comicDataProvider.isInMyComics(comicID, forSeriesID: seriesID)
    }
    
    // Bookmark
    
    func getBookmarkComics() -> [Comic]? {
        comicDataProvider.getBookmarkComics()
    }
    
    func addToBookmark(_ comicID: String) {
        comicDataProvider.addToBookmark(comicID)
    }
    
    func removeFromBookmark(_ comicID: String) {
        comicDataProvider.removeFromBookmark(comicID)
    }
    
    func isBookmarked(withID comicID: String) -> Bool {
        comicDataProvider.isBookmarked(withID: comicID)
    }

}
