//
//  FeedbackAPIWrapperFactory.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 03/09/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol FeedbackAPIWrapperFactory {

    var apiService: FeedbackAPIService { get }

    func makeAPIWrapper() -> FeedbackAPIWrapper

}

extension FeedbackAPIWrapperFactory {

    func makeAPIWrapper() -> FeedbackAPIWrapper {
        FeedbackAPIWrapper(apiService: apiService)
    }

}
