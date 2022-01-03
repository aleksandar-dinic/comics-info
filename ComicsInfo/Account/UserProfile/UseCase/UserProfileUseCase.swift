//
//  UserProfileUseCase.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 21/12/2021.
//

import Foundation

final class UserProfileUseCase: AuthRepositoryFactory {
    
    private lazy var repository = makeAuthRepository()

    let authAPIService: AuthAPIService
    
    init(authAPIService: AuthAPIService = AuthAPIProvider()) {
        self.authAPIService = authAPIService
    }
    
    func changePassword(
        oldPassword: String,
        newPassword: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.changePassword(
                oldPassword: oldPassword,
                newPassword: newPassword
            ) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }
    
    func signOut(
        globaly: Bool,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.signOut(globaly: globaly) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }
    
}
