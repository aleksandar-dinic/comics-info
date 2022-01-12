//
//  SignInViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 18/12/2021.
//

import Foundation
import SwiftUI
import AuthenticationServices

final class SignInViewModel: LoadableObject {
    
    enum Field {
        case username
        case password
    }
    
    private lazy var useCase = AuthUseCase()
    
    @Published private(set) var state: LoadingState<Void>
    @Published private(set) var showConfirmCode: Bool
    @Published var username: String
    @Published var password: String
    var alertController: AlertController?
    
    init(
        state: LoadingState<Void> = .idle,
        showConfirmCode: Bool = false,
        username: String = "",
        password: String = ""
    ) {
        self.state = state
        self.showConfirmCode = showConfirmCode
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
                    self.alertController?.info = AlertInfo(title: self.state.errorMessage)
                    return
                }
                self.state = .loaded(())
                self.showConfirmCode = true
            }
        }
    }
    
    func signInWithApple(
        onSignIn: @escaping () -> Void
    ) {
        useCase.signInWithApple { result in
            switch result {
            case .success:
                self.state = .loaded(())
                    onSignIn()
            case let .failure(error):
                guard case .signUpIsNotConfirmed = error as? AuthError else {
                    self.state = .failed(error)
                    self.alertController?.info = AlertInfo(title: self.state.errorMessage)
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
