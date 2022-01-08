//
//  UserProfileViewModel.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/12/2021.
//

import Foundation
import SwiftUI

final class UserProfileViewModel: ObservableObject {
    
    private lazy var useCase = UserProfileUseCase()
    
    private var user: User

    init(user: User) {
        self.user = user
    }
    
    func signOut(
        globaly: Bool = false,
        onSignOut: @escaping () -> ()
    ) {
        useCase.signOut(globaly: globaly) { result in
            switch result {
            case .success:
                onSignOut()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    var email: String {
        user.email ?? ""
    }
    
    var nickname: String {
        user.nickname ?? ""
    }
    
    var canChangePassword: Bool {
        user.authProvider == nil
    }

}
