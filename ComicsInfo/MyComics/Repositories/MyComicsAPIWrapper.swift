//
//  MyComicsAPIWrapper.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 2/1/22.
//

import struct Domain.MyCharacter
import struct Domain.ComicSummary
import Foundation

struct MyComicsAPIWrapper: DecoderService {
    
    private let myComicsAPIService: MyComicsAPIService

    init(myComicsAPIService: MyComicsAPIService) {
        self.myComicsAPIService = myComicsAPIService
    }
    
    // My Character
    
    func createMyCharacter(
        _ myCharacter: MyCharacter,
        token: String,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        do {
            let myCharacterData = try JSONEncoder().encode(myCharacter)
            myComicsAPIService.createMyCharacter(myCharacterData, token: token) { result in
                switch result {
                case let .success(data):
                    let decodedResult: Result<Domain.MyCharacter, Error> = decode(from: data)
                    complete(decodedResult.map({ MyCharacter(from: $0) }))

                case let .failure(error):
                    complete(.failure(error))
                }
            }
        } catch {
            complete(.failure(error))
        }
    }
 
    func getAllMyCharacters(
        token: String,
        onComplete complete: @escaping (Result<[MyCharacter], Error>) -> Void
    ) {
        myComicsAPIService.getAllMyCharacters(token: token) { result in
            switch result {
            case let .success(data):
                let decodedResult: Result<[Domain.MyCharacter], Error> = decode(from: data)
                complete(decodedResult.map({ $0.map ({ MyCharacter(from: $0) }) }))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    func getMyCharacter(
        withID identifier: String,
        token: String,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        myComicsAPIService.getMyCharacter(withID: identifier, token: token) { result in
            switch result {
            case let .success(data):
                let decodedResult: Result<Domain.MyCharacter, Error> = decode(from: data)
                complete(decodedResult.map({ MyCharacter(from: $0) }))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    func updateMyCharacter(
        _ myCharacter: MyCharacter,
        token: String,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        do {
            let identifier = myCharacter.identifier
            let data = try JSONEncoder().encode(myCharacter)
            myComicsAPIService.updateMyCharacter(data, withID: identifier, token: token) { result in
                switch result {
                case let .success(data):
                    let decodedResult: Result<Domain.MyCharacter, Error> = decode(from: data)
                    complete(decodedResult.map({ MyCharacter(from: $0) }))

                case let .failure(error):
                    complete(.failure(error))
                }
            }
        } catch {
            complete(.failure(error))
        }
    }
    
    func deleteMyCharacter(
        withID identifier: String,
        token: String,
        onComplete complete: @escaping (Result<MyCharacter, Error>) -> Void
    ) {
        myComicsAPIService.deleteMyCharacter(withID: identifier, token: token) { result in
            switch result {
            case let .success(data):
                let decodedResult: Result<Domain.MyCharacter, Error> = decode(from: data)
                complete(decodedResult.map({ MyCharacter(from: $0) }))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    // My Comics
    
    func createMyComic(
        _ myComic: ComicSummary,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        do {
            let myComicData = try JSONEncoder().encode(myComic)
            myComicsAPIService.createMyComic(myComicData, forSeriesID: seriesID, token: token) { result in
                switch result {
                case let .success(data):
                    let decodedResult: Result<Domain.ComicSummary, Error> = decode(from: data)
                    complete(decodedResult.map({ ComicSummary(from: $0) }))

                case let .failure(error):
                    complete(.failure(error))
                }
            }
        } catch {
            complete(.failure(error))
        }
    }
 
    func getAllMyComics(
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<[ComicSummary], Error>) -> Void
    ) {
        myComicsAPIService.getAllMyComics(forSeriesID: seriesID, token: token) { result in
            switch result {
            case let .success(data):
                let decodedResult: Result<[Domain.ComicSummary], Error> = decode(from: data)
                complete(decodedResult.map({ $0.map ({ ComicSummary(from: $0) }) }))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    func getMyComic(
        withID identifier: String,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        myComicsAPIService.getMyComic(withID: identifier, forSeriesID: seriesID, token: token) { result in
            switch result {
            case let .success(data):
                let decodedResult: Result<Domain.ComicSummary, Error> = decode(from: data)
                complete(decodedResult.map({ ComicSummary(from: $0) }))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    func updateMyComic(
        _ myComic: ComicSummary,
        withID identifier: String,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        do {
            let identifier = myComic.identifier
            let data = try JSONEncoder().encode(myComic)
            myComicsAPIService.updateMyComic(data, withID: identifier, forSeriesID: seriesID, token: token) { result in
                switch result {
                case let .success(data):
                    let decodedResult: Result<Domain.ComicSummary, Error> = decode(from: data)
                    complete(decodedResult.map({ ComicSummary(from: $0) }))

                case let .failure(error):
                    complete(.failure(error))
                }
            }
        } catch {
            complete(.failure(error))
        }
    }
    
    func deleteMyComic(
        withID identifier: String,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<ComicSummary, Error>) -> Void
    ) {
        myComicsAPIService.deleteMyComic(withID: identifier, forSeriesID: seriesID, token: token) { result in
            switch result {
            case let .success(data):
                let decodedResult: Result<Domain.ComicSummary, Error> = decode(from: data)
                complete(decodedResult.map({ ComicSummary(from: $0) }))

            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
}
