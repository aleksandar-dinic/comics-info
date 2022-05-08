//
//  MyComicsAPIService.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 2/1/22.
//

import Foundation

protocol MyComicsAPIService {
    
    // My Characters
    
    func createMyCharacter(
        _ myCharacter: Data,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )
 
    func getAllMyCharacters(
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )
    
    func getMyCharacter(
        withID identifier: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )
    
    func updateMyCharacter(
        _ myCharacter: Data,
        withID identifier: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )
    
    func deleteMyCharacter(
        withID identifier: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )
    
    // My Comics
    
    func createMyComic(
        _ myComic: Data,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )
 
    func getAllMyComics(
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )
    
    func getMyComic(
        withID identifier: String,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )
    
    func updateMyComic(
        _ myComic: Data,
        withID identifier: String,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )
    
    func deleteMyComic(
        withID identifier: String,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )
    
}
