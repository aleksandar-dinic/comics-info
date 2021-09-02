//
//  SupportViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 02/09/2021.
//

import SwiftUI
import Foundation

final class SupportViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var message = "Explain what you like or what could improve"
    private let placeholderString = "Explain what you like or what could improve"

    var textEditorForegroundColor: Color {
        message == placeholderString ? .gray.opacity(0.6) : .primary
    }
    
    var sendButtonIsDisabled: Bool {
        message.isEmpty || message == placeholderString 
    }
    
    func onTapTextEditor() {
        guard message == placeholderString else { return }
        message = ""
    }
    
}
