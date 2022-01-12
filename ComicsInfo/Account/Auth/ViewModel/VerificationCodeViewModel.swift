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
    @Published var confirmationCode: String

    private let alertController: AlertController
    private let username: String
    private let password: String

    init(
        state: LoadingState<Void> = .idle,
        confirmationCode: String = "",
        alertController: AlertController,
        username: String,
        password: String
    ) {
        self.state = state
        self.confirmationCode = confirmationCode
        self.alertController = alertController
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
                self.alertController.info = AlertInfo(title: self.state.errorMessage)
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
                self.alertController.info = AlertInfo(title: self.state.errorMessage)
            }
        }
    }
    
    func resendVerificationCode() {
        state = .loading(currentValue: nil)
        
        useCase.resendSignUpCode(for: username) { result in
            switch result {
            case .success:
                self.state = .loaded(())
                self.alertController.info = AlertInfo(
                    .verificationCodeSubmitted,
                    title: "We have sent a code. Check your email."
                )
            case let .failure(error):
                self.state = .failed(error)
                self.alertController.info = AlertInfo(title: self.state.errorMessage)
            }
        }
    }
    
    func isConfirmAccountDisabled() -> Bool {
        confirmationCode.isEmpty || isLoading
    }
    
}
