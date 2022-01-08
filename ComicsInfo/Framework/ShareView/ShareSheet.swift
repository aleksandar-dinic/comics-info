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
        UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 })
                .first?.windows
                .filter({ $0.isKeyWindow }).first?.rootViewController?.present(
            activityVC,
            animated: true,
            completion: nil
        )
    }
    
}
