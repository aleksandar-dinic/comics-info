//
//  AppTrackingManager.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 24/09/2021.
//

import AppTrackingTransparency
import SwiftUI
import Foundation

struct AppTrackingManager {
    
    static private(set) var authorization = false
    
    static func askForPermission() {
        ATTrackingManager.requestTrackingAuthorization() { (status) in
            authorization = status == .authorized
        }
    }
    
}
