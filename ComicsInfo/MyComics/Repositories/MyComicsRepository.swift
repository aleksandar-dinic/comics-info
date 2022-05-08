//
//  MyComicsRepository.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 2/1/22.
//

import Foundation

struct MyComicsRepository {
    
    private let myComicsDataProvider: MyComicsDataProvider

    init(myComicsDataProvider: MyComicsDataProvider) {
        self.myComicsDataProvider = myComicsDataProvider
    }
    
    func createMyCharacter(
        _ myCharacter: MyCharacter,
        token: String,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        myComicsDataProvider.createMyCharacter(myCharacter, token: token, onComplete: complete)
    }
 
    func getAllMyCharacters(
        token: String,
        onComplete complete: @escaping (Result<[MyCharacter], Error>) -> Void
    ) {
        myComicsDataProvider.getAllMyCharacters(token: token, onComplete: complete)
    }
    
    func getMyCharacter(
        withID myCharacterID: String,
        token: String,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        myComicsDataProvider.getMyCharacter(withID: myCharacterID, token: token, onComplete: complete)
    }
    
    func updateMyCharacter(
        _ myCharacter: MyCharacter,
        token: String,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        myComicsDataProvider.updateMyCharacter(myCharacter, token: token, onComplete: complete)
    }
    
    func deleteMyCharacter(
        withID myCharacterID: String,
        token: String,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        myComicsDataProvider.deleteMyCharacter(withID: myCharacterID, token: token, onComplete: complete)
    }
    
    // My Comics
    
    func createMyComic(
        _ myComic: ComicSummary,
        seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        myComicsDataProvider.createMyComic(
            myComic,
            seriesID: seriesID,
            token: token,
            onComplete: complete
        )
    }
    
    func getMyComics(
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<[ComicSummary], Error>) -> Void
    ) {
        myComicsDataProvider.getAllMyComics(forSeriesID: seriesID, token: token, onComplete: complete)
    }
    
    func getMyComic(
        withID comicID: String,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        myComicsDataProvider.getMyComic(withID: comicID, forSeriesID: seriesID, token: token, onComplete: complete)
    }
    
    func deleteMyComic(
        withID comicID: String,
        characterID: String,
        seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        myComicsDataProvider.deleteMyComic(withID: comicID, forSeriesID: seriesID, token: token, onComplete: complete)
    }
    
}
