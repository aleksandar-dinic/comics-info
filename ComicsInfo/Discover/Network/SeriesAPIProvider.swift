//
//  SeriesAPIProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class SeriesAPIProvider: SeriesAPIService, NetworkResponseHandler {

    private let session: URLSession
    private let networkManager: NetworkManager<SeriesEndpoint>
    
    init(
        session: URLSession = .shared,
        networkManager: NetworkManager<SeriesEndpoint> = NetworkManager<SeriesEndpoint>()
    ) {
        self.session = session
        self.networkManager = networkManager
    }
    
    func getAllSeries(onComplete complete: @escaping (Result<Data, Error>) -> Void) {
        networkManager.request(.getAllSeries) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.ok]))
        }
    }
    
    func getSeries(
        withID seriesID: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.getSeries(withID: seriesID)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.ok]))
        }
    }

}
