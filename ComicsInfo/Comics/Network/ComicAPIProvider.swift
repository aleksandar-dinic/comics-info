//
//  ComicAPIProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Combine
import Foundation

final class ComicAPIProvider: ComicAPIService, NetworkResponseHandler {

    private let session: URLSession
    private let networkManager: NetworkManager<ComicEndpoint>
    
    init(
        session: URLSession = .shared,
        networkManager: NetworkManager<ComicEndpoint> = NetworkManager<ComicEndpoint>()
    ) {
        self.session = session
        self.networkManager = networkManager
    }
    
    func getAllComics(
        for seriesID: String,
        afterID: String?,
        limit: Int,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.getAllComics(forSeriesID: seriesID, afterID: afterID, limit: limit)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.ok]))
        }
    }
    
//    func getAllComics(
//        for seriesID: String,
//        afterID: String?,
//        limit: Int
//    ) -> AnyPublisher<Data, Error> {
//        networkManager.request(.getAllComics(forSeriesID: seriesID, afterID: afterID, limit: limit))
//            .tryMap {
//                guard $0.response.statusCode == HTTPStatusCode.ok.rawValue else {
//                    throw URLError(.badServerResponse)
//                }
//                return $0.data
//            }
//            .eraseToAnyPublisher()
//    }
    
    func getComic(
        withID comicID: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.getComic(withID: comicID)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.ok]))
        }
    }

}
