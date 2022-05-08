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
    
    // Bookmark
    
    func getBookmarkComics(forSeriesID seriesID: String) -> [ComicSummary]? {
        comicDataProvider.getBookmarkComics(forSeriesID: seriesID)
    }
    
    func addToBookmark(_ comicSummary: ComicSummary, forSeriesID seriesID: String) {
        comicDataProvider.addToBookmark(comicSummary, forSeriesID: seriesID)
    }
    
    func removeFromBookmark(_ comicID: String, forSeriesID seriesID: String) {
        comicDataProvider.removeFromBookmark(comicID, forSeriesID: seriesID)
    }
    
    func isBookmarked(_ comicID: String, forSeriesID seriesID: String) -> Bool {
        comicDataProvider.isBookmarked(comicID, forSeriesID: seriesID)
    }
    
}
