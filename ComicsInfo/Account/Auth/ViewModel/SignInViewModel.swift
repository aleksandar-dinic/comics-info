//
//  SignInViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 18/12/2021.
//

import Foundation
import SwiftUI

final class SignInViewModel: LoadableObject {
    
    enum Field {
        case username
        case password
    }
    
    private lazy var useCase = AuthUseCase()
    
    @Published private(set) var state: LoadingState<Void>
    @Published private(set) var showConfirmCode: Bool
    @Published var showAlert: Bool
    @Published var username: String
    @Published var password: String
    
    init(
        state: LoadingState<Void> = .idle,
        showConfirmCode: Bool = false,
        showAlert: Bool = false,
        username: String = "",
        password: String = ""
    ) {
        self.state = state
        self.showConfirmCode = showConfirmCode
        self.showAlert = showAlert
        self.username = username
        self.password = password
    }
    
    func signIn(
        onSignIn: @escaping () -> Void
    ) {
        guard !isSignInDisabled() else { return }
        state = .loading(currentValue: nil)
        
        useCase.signIn(username: username, password: password) { result in
            switch result {
            case .success:
                self.state = .loaded(())
                onSignIn()
            case let .failure(error):
                guard case .signUpIsNotConfirmed = error as? AuthError else {
                    self.state = .failed(error)
                    self.showAlert = true
                    return
                }
                self.state = .loaded(())
                self.showConfirmCode = true
            }
        }
    }
    
    func isSignInDisabled() -> Bool {
        username.isEmpty ||
        password.isEmpty ||
        password.count < Environment.passwordMinLength ||
        isLoading
    }
    
}
