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
    private let useCase: FeedbackUseCase
    
    @Published var showAlert: Bool = false
    @Published private(set) var isLoading: Bool = false
    private(set) var alertMessage: String = ""
    
    init(useCase: FeedbackUseCase = FeedbackUseCase()) {
        self.useCase = useCase
    }
    
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
    
    func createFeedback(message: String, email: String?) {
        isLoading = true
        useCase.create(Feedback(message: message, email: email)) { result in
            switch result {
            case .success:
                self.alertMessage = "Thank you for your feedback 🤗"
            case .failure:
                self.alertMessage = "Something went wrong. Please try again later ❤️"
            }
            self.showAlert = true
            self.isLoading = false
        }
    }
    
}
