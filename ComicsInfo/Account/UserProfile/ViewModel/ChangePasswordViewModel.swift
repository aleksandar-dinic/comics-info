//
//  ChangePasswordViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 23/12/2021.
//

import Foundation
import SwiftUI

final class ChangePasswordViewModel: LoadableObject {
    
    private lazy var useCase = UserProfileUseCase()
    
    @Published private(set) var state: LoadingState<Void>
    @Published var showAlert: Bool
    @Published var oldPassword: String
    @Published var newPassword: String

    private(set) var passwordChanged: Bool
    
    init(
        state: LoadingState<Void> = .idle,
        showAlert: Bool = false,
        oldPassword: String = "",
        newPassword: String = "",
        passwordChanged: Bool = false
    ) {
        self.state = state
        self.showAlert = showAlert
        self.oldPassword = oldPassword
        self.newPassword = newPassword
        self.passwordChanged = passwordChanged
    }
    
    func changePassword() {
        guard !isChangePasswordDisabled() else { return }
        state = .loading(currentValue: nil)
        
        useCase.changePassword(oldPassword: oldPassword, newPassword: newPassword) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.state = .loaded(())
                self.passwordChanged = true
            case let .failure(error):
                self.state = .failed(error)
            }
            self.showAlert = true
        }
    }
    
    func isChangePasswordDisabled() -> Bool {
        oldPassword.isEmpty ||
        newPassword.isEmpty ||
        oldPassword.count < Environment.passwordMinLength ||
        newPassword.count < Environment.passwordMinLength ||
        isLoading
    }
    
    var alertMessage: String {
        guard !passwordChanged else {
            return "Password has been successfully changed"
        }
        return state.errorMessage
    }

}
