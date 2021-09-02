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
        static let adUnitID = "AD_UNIT_ID"
        static let comicsListADUnitID = "COMICS_LIST_AD_UNIT_ID"
        static let comicInfoADUnitID = "COMIC_INFO_AD_UNIT_ID"
        static let accountADUnitID = "ACCOUNT_AD_UNIT_ID"
        static let exploreADUnitID = "EXPLORE_AD_UNIT_ID"
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
    
    static let adUnitID: String = {
        guard let adUnitID = Environment.infoDictionary[Keys.adUnitID] as? String else {
            fatalError("😱 AD Unit ID is not set in plist for this environment")
        }
        return adUnitID
    }()
    
    static let comicsListADUnitID: String = {
        guard let comicsListADUnitID = Environment.infoDictionary[Keys.comicsListADUnitID] as? String else {
            fatalError("😱 ComicsList AD Unit ID is not set in plist for this environment")
        }
        return comicsListADUnitID
    }()
    
    static let comicInfoADUnitID: String = {
        guard let comicInfoADUnitID = Environment.infoDictionary[Keys.comicInfoADUnitID] as? String else {
            fatalError("😱 Comic Info AD Unit ID is not set in plist for this environment")
        }
        return comicInfoADUnitID
    }()
    
    static let accountADUnitID: String = {
        guard let accountADUnitID = Environment.infoDictionary[Keys.accountADUnitID] as? String else {
            fatalError("😱 Account AD Unit ID is not set in plist for this environment")
        }
        return accountADUnitID
    }()

    static let exploreADUnitID: String = {
        guard let exploreADUnitID = Environment.infoDictionary[Keys.exploreADUnitID] as? String else {
            fatalError("😱 Explore AD Unit ID is not set in plist for this environment")
        }
        return exploreADUnitID
    }()
    
}
