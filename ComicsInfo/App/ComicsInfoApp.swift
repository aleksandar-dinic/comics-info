//
//  ComicsInfoApp.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 10/08/2020.
//

import SwiftUI
import Firebase
import GoogleMobileAds

@main
struct ComicsInfoApp: App {
    
    init() {
        // Use Firebase library to configure APIs.
        FirebaseApp.configure()

        // Initialize the Google Mobile Ads SDK.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    var body: some Scene {
        WindowGroup {
            ExploreView()
        }
    }
    
}
