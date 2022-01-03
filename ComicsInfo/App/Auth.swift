//
//  Auth.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 19/12/2021.
//

import Amplify
import AWSCognitoAuthPlugin
import Foundation

struct Auth {
    
    static func configure() {
        do {
            Amplify.Logging.logLevel = .verbose
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
        } catch {
            print("An error occurred setting up Amplify: \(error)")
        }
    }
    
}
