//
//  ComicUseCase.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/07/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class ComicUseCase: ComicRepositoryFactory, CharacterRepositoryFactory, SeriesRepositoryFactory {

    private lazy var repository = makeComicRepository()
    lazy var characterRepository = makeCharacterRepository()
    lazy var seriesRepository = makeSeriesRepository()
    
    let comicAPIService: ComicAPIService
    let comicCacheService: ComicCacheService
    let characterAPIService: CharacterAPIService
    let characterCacheService: CharacterCacheService
    let seriesAPIService: SeriesAPIService
    let seriesCacheService: SeriesCacheService
    
        
    init(
        comicAPIService: ComicAPIService = ComicAPIProvider(),
        comicCacheService: ComicCacheService = ComicCacheProvider(),
        characterAPIService: CharacterAPIService = CharacterAPIProvider(),
        characterCacheService: CharacterCacheService = CharacterCacheProvider(),
        seriesAPIService: SeriesAPIService = SeriesAPIProvider(),
        seriesCacheService: SeriesCacheService = SeriesCacheProvider()
    ) {
        self.comicAPIService = comicAPIService
        self.comicCacheService = comicCacheService
        self.characterAPIService = characterAPIService
        self.characterCacheService = characterCacheService
        self.seriesAPIService = seriesAPIService
        self.seriesCacheService = seriesCacheService
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
    
    // My Comics
    
    func getMyComics(
        for seriesID: String,
        afterID: String?,
        limit: Int,
        fromDataSource dataSource: DataSourceLayer,
        onComplete complete: @escaping (Result<[ComicSummary], Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let comics = self?.repository.getMyComics(forSeriesID: seriesID), !comics.isEmpty else {
                DispatchQueue.main.async {
                    complete(.failure(NetworkError.missingData))
                }
                return
            }
            DispatchQueue.main.async {
                complete(.success(comics))
            }
        }
    }
    
    func addToMyComics(
        _ comicSummary: ComicSummary,
        character: Character,
        seriesSummary: SeriesSummary
    ) {
        repository.addToMyComics(
            comicSummary,
            character: character,
            seriesSummary: seriesSummary
        )
    }
    
    func isInMyComics(_ comicID: String, forSeriesID seriesID: String) -> Bool {
        repository.isInMyComics(comicID, forSeriesID: seriesID)
    }
    
    // Bookmark
    
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
