//
//  FeedbackDataRepository.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 03/09/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation

final class FeedbackDataRepository: FeedbackRepository {

    var dataProvider: FeedbackDataProvider

    init(dataProvider: FeedbackDataProvider) {
        self.dataProvider = dataProvider
    }

    func create(
        _ feedback: Feedback,
        onComplete complete: @escaping (Result<Feedback, Error>) -> Void
    ) {
        dataProvider.create(feedback, onComplete: complete)
    }
    
}
