//
//  FeedbackDataProviderFactory.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 03/09/2021.
//  Copyright © 2020 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol FeedbackDataProviderFactory: FeedbackAPIWrapperFactory {

    func makeDataProvider() -> FeedbackDataProvider

}

extension FeedbackDataProviderFactory {

    func makeDataProvider() -> FeedbackDataProvider {
        FeedbackDataProvider(apiWrapper: makeAPIWrapper())
    }

}
