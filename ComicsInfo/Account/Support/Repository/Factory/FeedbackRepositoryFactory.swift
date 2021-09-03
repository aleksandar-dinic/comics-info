//
//  FeedbackRepositoryFactory.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 03/09/2021.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol FeedbackRepositoryFactory: FeedbackDataProviderFactory {

    func makeRepository() -> FeedbackRepository

}

extension FeedbackRepositoryFactory {

    func makeRepository() -> FeedbackRepository {
        FeedbackDataRepository(dataProvider: makeDataProvider())
    }

}

