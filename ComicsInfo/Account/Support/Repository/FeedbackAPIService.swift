//
//  FeedbackAPIService.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 03/09/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation

protocol FeedbackAPIService {

    func create(
        _ feedback: Data,
        token: String?,
        onComplete complete: @escaping (Result<Data, Error>) -> Void
    )
    
}
