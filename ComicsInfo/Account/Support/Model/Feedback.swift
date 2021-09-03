//
//  Feedback.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 03/09/2021.
//

import struct Domain.Feedback
import Foundation

struct Feedback: Codable {
    
    let message: String
    let email: String?
    
}

extension Feedback {
    
    init(from feedback: Domain.Feedback) {
        self.init(
            message: feedback.message,
            email: feedback.email
        )
    }
    
}

extension Domain.Feedback {
    
    init(from feedback: Feedback) {
        self.init(
            message: feedback.message,
            email: feedback.email
        )
    }
    
}
