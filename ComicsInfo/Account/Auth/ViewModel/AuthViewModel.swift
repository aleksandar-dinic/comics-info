//
//  AuthViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/12/2021.
//

import Foundation
import SwiftUI

final class AuthViewModel: ObservableObject {
    
    private lazy var useCase = AuthUseCase()
    
    @Published private(set) var user: User?

    init(user: User? = nil) {
        self.user = user
    }

    func getCurrentUser() {
        guard let user = useCase.getCurrentUser() else {
            self.user = nil
            return
        }
        self.user = user
        getUserAttributes()
    }
    
    private func getUserAttributes() {
        useCase.getUserAttributes { [weak self] result in
            guard let self = self else { return }
            guard let attributes = try? result.get() else {
                return
            }
            self.user?.update(with: attributes)
        }
    }
    
    var myAccount: String {
        "My Account"
    }
    
}
