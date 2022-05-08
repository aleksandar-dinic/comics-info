//
//  MyComicsAPIProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 2/1/22.
//

import Foundation

final class MyComicsAPIProvider: MyComicsAPIService, NetworkResponseHandler {
    
    private let session: URLSession
    private let networkManager: NetworkManager<MyComicsEndpoint>
    
    init(
        session: URLSession = .shared,
        networkManager: NetworkManager<MyComicsEndpoint> = NetworkManager<MyComicsEndpoint>()
    ) {
        self.session = session
        self.networkManager = networkManager
    }
    
    func createMyCharacter(
        _ myCharacter: Data,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.createMyCharacter(myCharacter, token: token)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.created]))
        }
    }
    
    func getAllMyCharacters(
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.getAllMyCharacters(token: token)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.ok]))
        }
    }
    
    func getMyCharacter(
        withID identifier: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.getMyCharacter(withID: identifier, token: token)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.ok]))
        }
    }
    
    func updateMyCharacter(
        _ myCharacter: Data,
        withID identifier: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.updateMyCharacter(myCharacter, withID: identifier, token: token)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.ok]))
        }
    }
    
    func deleteMyCharacter(
        withID identifier: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.deleteMyCharacter(withID: identifier, token: token)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.ok]))
        }
    }
    
    // My Comics
    
    func createMyComic(
        _ myComic: Data,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.createMyComic(myComic, seriesID: seriesID, token: token)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.created]))
        }
    }
    
    func getAllMyComics(
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.getAllMyComics(seriesID: seriesID, token: token)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.ok]))
        }
    }
    
    func getMyComic(
        withID identifier: String,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.getMyComic(withID: identifier, seriesID: seriesID, token: token)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.ok]))
        }
    }
    
    func updateMyComic(
        _ myComic: Data,
        withID identifier: String,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.updateMyComic(myComic, withID: identifier, seriesID: seriesID, token: token)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.ok]))
        }
    }
    
    func deleteMyComic(
        withID identifier: String,
        forSeriesID seriesID: String,
        token: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.deleteMyComic(withID: identifier, seriesID: seriesID, token: token)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.ok]))
        }
    }
    
}
