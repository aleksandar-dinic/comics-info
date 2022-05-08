//
//  FeedbackUseCase.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 03/09/2021.
//

import Foundation

final class FeedbackUseCase: FeedbackRepositoryFactory {
    
    private lazy var repository = makeRepository()
    private lazy var authUseCase = AuthUseCase()
    
    let apiService: FeedbackAPIService
    
    init(apiService: FeedbackAPIService = FeedbackAPIProvider()) {
        self.apiService = apiService
    }
    
    func create(
        _ feedback: Feedback,
        onComplete complete: @escaping (Result<Feedback, Error>) -> Void
    ) {
        authUseCase.getAccessToken { result in
            let token = try? result.get()
            DispatchQueue.global(qos: .utility).async { [weak self] in
                self?.repository.create(feedback, token: token) { result in
                    DispatchQueue.main.async {
                        complete(result)
                    }
                }
            }
        }
    }
    
}
