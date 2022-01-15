//
//  ResetPasswordViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 22/12/2021.
//

import Foundation
import SwiftUI

final class ResetPasswordViewModel: LoadableObject {
    
    private lazy var useCase = AuthUseCase()
    
    @Published private(set) var state: LoadingState<Void>
    @Published private(set) var showConfirmCode: Bool
    @Published var showAlert: Bool
    @Published var username: String
    @Published var newPassword: String
    @Published var confirmationCode: String

    private(set) var passwordHasBeenReset: Bool
    
    init(
        state: LoadingState<Void> = .idle,
        showConfirmCode: Bool = false,
        showAlert: Bool = false,
        username: String = "",
        newPassword: String = "",
        confirmationCode: String = "",
        passwordHasBeenReset: Bool = false
    ) {
        self.state = state
        self.showConfirmCode = showConfirmCode
        self.showAlert = showAlert
        self.username = username
        self.newPassword = newPassword
        self.confirmationCode = confirmationCode
        self.passwordHasBeenReset = passwordHasBeenReset
    }
    
    func resetPassword() {
        guard !isResetPasswordDisabled() else { return }
        state = .loading(currentValue: nil)

        useCase.resetPassword(for: username) { [weak self] result in
            guard let self = self else { return }
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
    
    func confirmResetPassword() {
        guard !isConfirmResetPasswordDisabled() else { return }
        state = .loading(currentValue: nil)
        
        useCase.confirmResetPassword(
            for: username,
            with: newPassword,
            confirmationCode: confirmationCode
        ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.state = .loaded(())
                self.passwordHasBeenReset = true
            case let .failure(error):
                self.state = .failed(error)
            }
            self.showAlert = true
        }
    }
    
    func isResetPasswordDisabled() -> Bool {
        username.isEmpty ||
        isLoading
    }
    
    func isConfirmResetPasswordDisabled() -> Bool {
        username.isEmpty ||
        newPassword.isEmpty ||
        confirmationCode.isEmpty ||
        newPassword.count < Environment.passwordMinLength ||
        isLoading
    }
    
    func isUsernameDisabled() -> Bool {
        passwordHasBeenReset || isInputDisabled()
    }
    
    func usernameInputOpacity() -> Double {
        isUsernameDisabled() ? 0.6 : 1
    }
    
    func usernameImageOpacity() -> Double {
        isUsernameDisabled() ? 0.3 : 0.6
    }
    
    func inputOpacity() -> Double {
        isInputDisabled() ? 0.6 : 1
    }
    
    func imageOpacity() -> Double {
        isInputDisabled() ? 0.3 : 0.6
    }
    
    var alertMessage: String {
        guard !passwordHasBeenReset else {
            return "Your password has been changed successfully."
        }
        return state.errorMessage
    }
        
}
