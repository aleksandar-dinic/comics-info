//
//  MyComicsDataProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 2/2/22.
//

import Foundation

struct MyComicsDataProvider {

    private let myComicsAPIWrapper: MyComicsAPIWrapper
    private let myComicsCacheService: MyComicsCacheService

    init(
        myComicsAPIWrapper: MyComicsAPIWrapper,
        myComicsCacheService: MyComicsCacheService
    ) {
        self.myComicsAPIWrapper = myComicsAPIWrapper
        self.myComicsCacheService = myComicsCacheService
    }

    // My Character
    
    func createMyCharacter(
        _ myCharacter: MyCharacter,
        token: String,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        myComicsAPIWrapper.createMyCharacter(myCharacter, token: token) { result in
            switch result {
            case let .success(myCharacter):
                myComicsCacheService.saveMyCharacters([myCharacter])
                complete(.success(myCharacter))
            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    func getAllMyCharacters(
        token: String,
        onComplete complete: @escaping (Result<[MyCharacter], Error>) -> Void
    ) {
        if let myCharacters = myComicsCacheService.getAllMyCharacters(), !myCharacters.isEmpty {
            return complete(.success(myCharacters))
        }
        
        // TODO: - Set last check time
        complete(.failure(NetworkError.noContent(nil)))
//        myComicsAPIWrapper.getAllMyCharacters(token: token) { result in
//            switch result {
//            case let .success(myCharacters):
//                myComicsCacheService.saveMyCharacters(myCharacters)
//                complete(.success(myCharacters))
//            case let .failure(error):
//                complete(.failure(error))
//            }
//        }
    }
    
    func getMyCharacter(
        withID myCharacterID: String,
        token: String,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        if let myCharacter = myComicsCacheService.getMyCharacter(withID: myCharacterID) {
            return complete(.success(myCharacter))
        }
        
        // TODO: - Set last check time
        complete(.failure(NetworkError.noContent(nil)))
//        myComicsAPIWrapper.getMyCharacter(withID: myCharacterID, token: token) { result in
//            switch result {
//            case let .success(myCharacter):
//                myComicsCacheService.saveMyCharacters([myCharacter])
//                complete(.success(myCharacter))
//            case let .failure(error):
//                complete(.failure(error))
//            }
//        }
    }
    
    func updateMyCharacter(
        _ myCharacter: MyCharacter,
        token: String,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        myComicsAPIWrapper.updateMyCharacter(myCharacter, token: token) { result in
            switch result {
            case let .success(myCharacter):
                myComicsCacheService.updateMyCharacter(myCharacter)
                complete(.success(myCharacter))
            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    func deleteMyCharacter(
        withID myCharacterID: String,
        token: String,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        myComicsAPIWrapper.deleteMyCharacter(withID: myCharacterID, token: token) { result in
            switch result {
            case let .success(myCharacter):
                myComicsCacheService.removeMyCharacter(withID: myCharacter.identifier)
                complete(.success(myCharacter))
            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    // My Comics
    
    func createMyComic(
        _ myComic: ComicSummary,
        seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        myComicsAPIWrapper.createMyComic(myComic, forSeriesID: seriesID, token: token) { result in
            switch result {
            case let .success(myComics):
                myComicsCacheService.saveMyComics([myComics], forSeriesID: seriesID)
                complete(.success(myComics))
            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    func getAllMyComics(
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<[ComicSummary], Error>) -> Void
    ) {
        if let myComics = myComicsCacheService.getAllMyComics(forSeriesID: seriesID), !myComics.isEmpty {
            return complete(.success(myComics))
        }
        
        // TODO: - Set last check time
        complete(.failure(NetworkError.noContent(nil)))
//        myComicsAPIWrapper.getAllMyComics(forSeriesID: seriesID, token: token) { result in
//            switch result {
//            case let .success(myComics):
//                myComicsCacheService.saveMyComics(myComics, forSeriesID: seriesID)
//                complete(.success(myComics))
//            case let .failure(error):
//                complete(.failure(error))
//            }
//        }
    }
    
    func getMyComic(
        withID myComicsID: String,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        if let myComic = myComicsCacheService.getMyComic(withID: myComicsID, forSeriesID: seriesID) {
            return complete(.success(myComic))
        }
        
        // TODO: - Set last check time
        complete(.failure(NetworkError.noContent(nil)))
//        myComicsAPIWrapper.getMyComic(withID: myComicsID, forSeriesID: seriesID, token: token) { result in
//            switch result {
//            case let .success(myComic):
//                myComicsCacheService.saveMyComics([myComic], forSeriesID: seriesID)
//                complete(.success(myComic))
//            case let .failure(error):
//                complete(.failure(error))
//            }
//        }
    }
    
    func updateMyComic(
        _ myComic: ComicSummary,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        myComicsAPIWrapper.updateMyComic(myComic, withID: myComic.identifier, forSeriesID: seriesID, token: token) { result in
            switch result {
            case let .success(myComic):
                myComicsCacheService.updateMyComic(myComic, forSeriesID: seriesID)
                complete(.success(myComic))
            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    func deleteMyComic(
        withID myComicID: String,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        myComicsAPIWrapper.deleteMyComic(withID: myComicID, forSeriesID: seriesID, token: token) { result in
            switch result {
            case let .success(myComic):
                myComicsCacheService.removeMyComic(withID: myComic.identifier, forSeriesID: seriesID)
                complete(.success(myComic))
            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
}
