//
//  FeedbackRepository.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 03/09/2021.
//

import Foundation

protocol FeedbackRepository {
    
    var dataProvider: FeedbackDataProvider { get }

    init(dataProvider: FeedbackDataProvider)

    func create(
        _ feedback: Feedback,
        onComplete complete: @escaping (Result<Feedback, Error>) -> Void
    )
    
}
