//
//  FeedbackAPIWrapper.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 03/09/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import struct Domain.Feedback
import Foundation

struct FeedbackAPIWrapper: DecoderService {

    private let apiService: FeedbackAPIService

    init(apiService: FeedbackAPIService) {
        self.apiService = apiService
    }

    func create(
        _ feedback: Feedback,
        onComplete complete: @escaping (Result<Feedback, Error>) -> Void
    ) {
        do {
            let data = try JSONEncoder().encode(Domain.Feedback(from: feedback))
            apiService.create(data) { result in
                switch result {
                case let .success(data):
                    let decodedResult: Result<Domain.Feedback, Error> = decode(from: data)
                    complete(decodedResult.map({ Feedback(from: $0) }))

                case let .failure(error):
                    complete(.failure(error))
                }
            }
        } catch {
            return complete(.failure(error))
        }
    }
    
}
