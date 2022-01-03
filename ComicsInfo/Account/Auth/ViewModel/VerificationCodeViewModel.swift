//
//  VerificationCodeViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 26/12/2021.
//

import Foundation
import SwiftUI

final class VerificationCodeViewModel: LoadableObject {
    
    private lazy var useCase = AuthUseCase()
    
    @Published private(set) var state: LoadingState<Void>
    @Published var showAlert: Bool
    @Published var verificationCodeSubmitted: Bool
    @Published var confirmationCode: String

    private let username: String
    private let password: String

    init(
        state: LoadingState<Void> = .idle,
        showAlert: Bool = false,
        verificationCodeSubmitted: Bool = false,
        confirmationCode: String = "",
        username: String,
        password: String
    ) {
        self.state = state
        self.showAlert = showAlert
        self.verificationCodeSubmitted = verificationCodeSubmitted
        self.confirmationCode = confirmationCode
        self.username = username
        self.password = password
    }
    
    func confirmSignUp(
        onComplete complete: @escaping () -> Void
    ) {
        guard !isConfirmAccountDisabled() else { return }
        state = .loading(currentValue: nil)
        
        useCase.confirmSignUp(for: username, with: confirmationCode) { result in
            switch result {
            case .success:
                self.autoSignIn(onComplete: complete)
            case let .failure(error):
                self.state = .failed(error)
                self.showAlert = true
            }
        }
    }
    
    private func autoSignIn(
        onComplete complete: @escaping () -> Void
    ) {
        useCase.signIn(username: username, password: password) { result in
            switch result {
            case .success:
                self.state = .loaded(())
                complete()
            case let .failure(error):
                self.state = .failed(error)
                self.showAlert = true
            }
        }
    }
    
    func resendVerificationCode() {
        state = .loading(currentValue: nil)
        
        useCase.resendSignUpCode(for: username) { result in
            switch result {
            case .success:
                self.state = .loaded(())
                self.verificationCodeSubmitted = true
            case let .failure(error):
                self.state = .failed(error)
            }
            self.showAlert = true
        }
    }
    
    func isConfirmAccountDisabled() -> Bool {
        confirmationCode.isEmpty
    }
    
    var alertMessage: String {
        guard !verificationCodeSubmitted else {
            return "We have sent a code. Check your email."
        }
        return state.errorMessage
    }
    
}
