//
//  AuthUseCase.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 18/12/2021.
//

import Foundation

final class AuthUseCase: AuthRepositoryFactory {
    
    private lazy var repository = makeAuthRepository()

    let authAPIService: AuthAPIService
    
    init(authAPIService: AuthAPIService = AuthAPIProvider()) {
        self.authAPIService = authAPIService
    }
    
    func getCurrentUser() -> User? {
        repository.getCurrentUser()
    }
    
    func getUserAttributes(
        onComplete complete: @escaping (Result<[UserAttribute], Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.getUserAttributes { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }
    
    func signIn(
        username: String,
        password: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.signIn(username: username, password: password) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }
    
    func signInWithApple(
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        repository.signInWithApple { result in
            DispatchQueue.main.async {
                complete(result)
            }
        }
    }
    
    func resetPassword(
        for username: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.resetPassword(for: username) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }
    
    func confirmResetPassword(
        for username: String,
        with newPassword: String,
        confirmationCode: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.confirmResetPassword(
                for: username,
                with: newPassword,
                confirmationCode: confirmationCode
            ) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }
    
    func signUp(
        username: String,
        email: String,
        password: String,
        onComplete complete: @escaping (Result<Bool, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.signUp(username: username, email: email, password: password) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }
    
    func resendSignUpCode(
        for username: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.resendSignUpCode(for: username) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }
    
    func confirmSignUp(
        for email: String,
        with confirmationCode: String,
        onComplete complete: @escaping (Result<Bool, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            self?.repository.confirmSignUp(for: email, with: confirmationCode) { result in
                DispatchQueue.main.async {
                    complete(result)
                }
            }
        }
    }
    
}
