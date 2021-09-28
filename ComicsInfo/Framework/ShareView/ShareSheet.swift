//
//  ShareSheet.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 28/09/2021.
//

import SwiftUI
import Foundation

struct ShareSheet {
    
    func actionSheet(_ items: [String]) {
        let activityVC = UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
        UIApplication.shared.windows.first?.rootViewController?.present(
            activityVC,
            animated: true,
            completion: nil
        )
    }
    
}
