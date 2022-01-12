//
//  AlertInfo.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 11/01/2022.
//

import SwiftUI

struct AlertInfo: Identifiable {

    enum AlertType {
        case error
        case verificationCodeSubmitted
    }
    
    let id: AlertType
    let title: String
    let message: String
    let dismissButton: Alert.Button
    
    init(
        _ id: AlertType = .error,
        title: String,
        message: String = "",
        dismissButton: Alert.Button = .default(Text("OK"))
    ) {
        self.id = id
        self.title = title
        self.message = message
        self.dismissButton = dismissButton
    }

}
