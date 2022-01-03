//
//  SignUpViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 18/12/2021.
//

import Foundation
import SwiftUI

final class SignUpViewModel: LoadableObject {
    
    private lazy var useCase = AuthUseCase()
    
    @Published private(set) var state: LoadingState<Void>
    @Published private(set) var showConfirmCode: Bool
    @Published var showAlert: Bool
    @Published var username: String
    @Published var email: String
    @Published var password: String

    init(
        state: LoadingState<Void> = .idle,
        showConfirmCode: Bool = false,
        showAlert: Bool = false,
        username: String = "",
        email: String = "",
        password: String = ""
    ) {
        self.state = state
        self.showConfirmCode = showConfirmCode
        self.showAlert = showAlert
        self.username = username
        self.email = email
        self.password = password
    }
    
    func signUp() {
        guard !isSignUpDisabled() else { return }
        state = .loading(currentValue: nil)
        
        useCase.signUp(
            username: username,
            email: email,
            password: password
        ) { result in
            switch result {
            case .success:
                self.state = .loaded(())
                self.showConfirmCode = true
            case let .failure(error):
                self.state = .failed(error)
                self.showAlert = true
            }
        }
    }
    
    func isSignUpDisabled() -> Bool {
        username.isEmpty ||
        email.isEmpty ||
        password.count < Environment.passwordMinLength ||
        isLoading
    }
    
    func inputOpacity() -> Double {
        isInputDisabled() ? 0.6 : 1
    }
    
    func imageOpacity() -> Double {
        isInputDisabled() ? 0.3 : 0.6
    }
    
}
