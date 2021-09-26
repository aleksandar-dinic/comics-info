//
//  CharacterAPIProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/08/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class CharacterAPIProvider: CharacterAPIService, NetworkResponseHandler {
    
    private let session: URLSession
    private let networkManager: NetworkManager<CharacterEndpoint>
    
    init(
        session: URLSession = .shared,
        networkManager: NetworkManager<CharacterEndpoint> = NetworkManager<CharacterEndpoint>()
    ) {
        self.session = session
        self.networkManager = networkManager
    }

    func getAllCharacters(
        afterID: String?,
        fields: Set<String>?,
        limit: Int,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.getAllCharacters(afterID: afterID, fields: fields, limit: limit)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.ok]))
        }
    }

    func getCharacter(
        withID characterID: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        networkManager.request(.getCharacter(withID: characterID)) { [weak self] in
            guard let self = self else { return }
            complete(self.handle($0, successStatuses: [.ok]))
        }
    }

}
