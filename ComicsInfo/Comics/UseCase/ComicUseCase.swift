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
    private lazy var characterUseCase = CharacterUseCase()
    private lazy var myComicsUseCase = MyComicsUseCase()
    
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
    
    // My Comics
    
    func addToMyComics(
        _ comicSummary: ComicSummary,
        seriesSummary: SeriesSummary,
        character: Character,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        myComicsUseCase.createMyComic(
            comicSummary,
            seriesSummary: seriesSummary,
            character: character,
            onComplete: complete
        )
    }
    
    func getMyComics(
        for seriesID: String,
        onComplete complete: @escaping (Result<[ComicSummary], Error>) -> Void
    ) {
        myComicsUseCase.getMyComics(forSeriesID: seriesID, onComplete: complete)
    }
    
    func isInMyComics(
        _ comicID: String,
        forSeriesID seriesID: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        myComicsUseCase.getMyComic(withID: comicID, forSeriesID: seriesID) { result in
            switch result {
            case .success:
                complete(.success(()))
            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    func removeFromMyComics(
        _ comicID: String,
        seriesID: String,
        characterID: String,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        myComicsUseCase.deleteMyComic(withID: comicID, characterID: characterID, seriesID: seriesID, onComplete: complete)
    }
    
    func removeMySeries(
        withID seriesID:
        String, characterID: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        myComicsUseCase.removeMySeries(withID: seriesID, characterID: characterID, onComplete: complete)
    }
    
    // Bookmark
    
    func getBookmarkComics(forSeriesID seriesID: String) -> [ComicSummary]? {
        repository.getBookmarkComics(forSeriesID: seriesID)
    }
    
    func addToBookmark(
        _ comicSummary: ComicSummary,
        seriesSummary: SeriesSummary,
        character: Character
    ) {
        let myCharacter = MyCharacter(from: character, mySeries: [seriesSummary])
        characterUseCase.updateBookmared(myCharacter)
        repository.addToBookmark(comicSummary, forSeriesID: seriesSummary.identifier)
    }
    
    func removeFromBookmark(_ comicID: String, forSeriesID seriesID: String) {
        repository.removeFromBookmark(comicID, forSeriesID: seriesID)
    }
    
    func isBookmarked(_ comicID: String, forSeriesID seriesID: String) -> Bool {
        repository.isBookmarked(comicID, forSeriesID: seriesID)
    }
    
    // User
    
    func isUserSignedIn() -> Bool {
        myComicsUseCase.isUserSignedIn()
    }
    
}
