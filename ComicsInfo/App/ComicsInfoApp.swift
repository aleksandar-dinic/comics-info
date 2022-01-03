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
        Auth.configure()

        // Use Firebase library to configure APIs.
        FirebaseApp.configure()

        // Initialize the Google Mobile Ads SDK.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .onReceive(
                    NotificationCenter.default.publisher(
                        for: UIApplication.didBecomeActiveNotification
                    )
                ) { _ in
                    AppTrackingManager.askForPermission()
                }
        }
    }
    
}
