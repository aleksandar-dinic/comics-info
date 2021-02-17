//
//  Environment.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 17/02/2021.
//  Copyright © 2021 Aleksandar Dinic. All rights reserved.
//

import Foundation

enum Environment {
    
    private enum Keys {
        static let rootURL = "ROOT_URL"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("😱 Plist file not found")
        }
        return dict
    }()

    static let rootURL: URL = {
        guard let rootURLstring = Environment.infoDictionary[Keys.rootURL] as? String else {
            fatalError("😱 Root URL not set in plist for this environment")
        }
        guard let url = URL(string: rootURLstring) else {
            fatalError("😱 Root URL is invalid")
        }
        return url
    }()

}
