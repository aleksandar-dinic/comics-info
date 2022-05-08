//
//  AuthRepository.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 18/12/2021.
//

import Foundation

struct AuthRepository {
    
    private let authAPIService: AuthAPIService
    private let keychainWrapper: KeychainWrapper
    
    init(
        authAPIService: AuthAPIService,
        keychainWrapper: KeychainWrapper = KeychainWrapper()
    ) {
        self.authAPIService = authAPIService
        self.keychainWrapper = keychainWrapper
    }
    
    func getCurrentUser() -> User? {
        authAPIService.getCurrentUser()
    }
    
    func getUserAttributes(
        onComplete complete: @escaping (Result<[UserAttribute], Error>) -> Void
    ) {
        authAPIService.getUserAttributes(onComplete: complete)
    }
    
    func getAccessToken(
        onComplete complete: @escaping (Result<String, Error>) -> Void
    ) {
        authAPIService.getAccessToken(onComplete: complete)
    }
    
    func signIn(
        username: String,
        password: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        authAPIService.signIn(
            username: username,
            password: password,
            onComplete: complete
        )
    }
    
    func signInWithApple(
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        authAPIService.signInWithApple(onComplete: complete)
    }
    
    func resetPassword(
        for username: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        authAPIService.resetPassword(
            for: username,
            onComplete: complete
        )
    }
    
    func confirmResetPassword(
        for username: String,
        with newPassword: String,
        confirmationCode: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        authAPIService.confirmResetPassword(
            for: username,
            with: newPassword,
            confirmationCode: confirmationCode,
            onComplete: complete
        )
    }
    
    func changePassword(
        oldPassword: String,
        newPassword: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        authAPIService.changePassword(
            oldPassword: oldPassword,
            newPassword: newPassword,
            onComplete: complete
        )
    }
    
    func signUp(
        username: String,
        email: String,
        password: String,
        onComplete complete: @escaping (Result<Bool, Error>) -> Void
    ) {
        authAPIService.signUp(
            username: username,
            email: email,
            password: password
        ) { result in
            switch result {
            case let .success(val):
                try? keychainWrapper.store(password, for: username, service: "InfoAboutComics")
                complete(.success(val))
            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    func resendSignUpCode(
        for username: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        authAPIService.resendSignUpCode(
            for: username,
            onComplete: complete
        )
    }
    
    func confirmSignUp(
        for username: String,
        with confirmationCode: String,
        onComplete complete: @escaping (Result<Bool, Error>) -> Void
    ) {
        authAPIService.confirmSignUp(
            for: username,
            with: confirmationCode,
            onComplete: complete
        )
    }
    
    func signOut(
        globaly: Bool,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        authAPIService.signOut(
            globaly: globaly,
            onComplete: complete
        )
    }
    
}
