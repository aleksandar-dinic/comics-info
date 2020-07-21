//
//  SeriesAPIServiceMock.swift
//  UseCasesTests
//
//  Created by Aleksandar Dinic on 22/05/2020.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import protocol CIData.SeriesAPIService
import Foundation

final class SeriesAPIServiceMock: SeriesAPIService {

    private let data: Data?

    init(_ data: Data? = nil) {
        self.data = data
    }

    func getSeries(
        forCharacterID characterID: String,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let data = data else {
            return complete(.failure(ErrorMock.noData))
        }
        complete(.success(data))
    }

}
