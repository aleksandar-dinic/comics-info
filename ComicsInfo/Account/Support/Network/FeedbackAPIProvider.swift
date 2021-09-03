//
//  FeedbackAPIProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 03/09/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Feedback
import Foundation

final class FeedbackAPIProvider: FeedbackAPIService, NetworkResponseHandler {

    private let session: URLSession
    private let networkManager: NetworkManager<FeedbackEndpoint>
    
    init(
        session: URLSession = .shared,
        networkManager: NetworkManager<FeedbackEndpoint> = NetworkManager<FeedbackEndpoint>()
    ) {
        self.session = session
        self.networkManager = networkManager
    }
    
    func create(
        _ feedback: Data,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.create(feedback: feedback)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.created]))
        }
    }
    
}
