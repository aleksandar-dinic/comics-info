//
//  ComicUseCase.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class ComicUseCase: ComicRepositoryFactory {

    private lazy var repository = makeComicRepository()

    let comicAPIService: ComicAPIService
    let comicCacheService: ComicCacheService

    init(
        comicAPIService: ComicAPIService = ComicAPIProvider(),
        comicCacheService: ComicCacheService = ComicCacheProvider()
    ) {
        self.comicAPIService = comicAPIService
        self.comicCacheService = comicCacheService
    }
    
    func getComicSummaries(
        for seriesID: String,
        afterID: String?,
        limit: Int,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[ComicSummary], Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.getComicSummaries(for: seriesID, afterID: afterID, limit: limit, fromDataSource: dataSource) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }
    
    func getComic(
        withID comicID: String,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<Comic, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.getComic(withID: comicID, fromDataSource: dataSource) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }
    
    func getBookmarkComics() -> [Comic]? {
        repository.getBookmarkComics()
    }
    
    func addToBookmark(_ comicID: String) {
        repository.addToBookmark(comicID)
    }
    
    func removeFromBookmark(_ comicID: String) {
        repository.removeFromBookmark(comicID)
    }
    
    func isBookmarked(withID comicID: String) -> Bool {
        repository.isBookmarked(withID: comicID)
    }

}
