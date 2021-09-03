//
//  FeedbackDataProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 03/09/2021.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

struct FeedbackDataProvider {

    private let apiWrapper: FeedbackAPIWrapper

    init(apiWrapper: FeedbackAPIWrapper) {
        self.apiWrapper = apiWrapper
    }
    
    func create(
        _ feedback: Feedback,
        onComplete complete: @escaping (Result<Feedback, Error>) -> Void
    ) {
        apiWrapper.create(feedback, onComplete: complete)
    }

}
