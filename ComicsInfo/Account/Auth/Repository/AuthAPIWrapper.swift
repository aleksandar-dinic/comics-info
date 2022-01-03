//
//  AuthAPIWrapper.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 18/12/2021.
//

import Foundation

struct AuthAPIWrapper: DecoderService {
    
    private let authAPIService: AuthAPIService

    init(authAPIService: AuthAPIService) {
        self.authAPIService = authAPIService
    }
    
    func getCurrentUser(
        onComplete complete: @escaping (Result<User, Error>) -> Void
    ) {
        authAPIService.getCurrentUser { result in
            switch result {
            case let .success(data):
                complete(decode(from: data))
            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    func signIn(
        username: String,
        password: String,
        onComplete complete: @escaping (Result<Bool, Error>) -> Void
    ) {
        authAPIService.signIn(username: username, password: password) { result in
            switch result {
            case let .success(data):
                let decodedResult: Result<Bool, Error> = decode(from: data)
                complete(decodedResult)
            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    func signUp(
        email: String,
        username: String,
        password: String,
        onComplete complete: @escaping (Result<Bool, Error>) -> Void
    ) {
        authAPIService.signUp(email: email, username: username, password: password) { result in
            switch result {
            case let .success(data):
                let decodedResult: Result<Bool, Error> = decode(from: data)
                complete(decodedResult)
            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
    func confirmSignUp(
        for username: String,
        with confirmationCode: String,
        onComplete complete: @escaping (Result<Bool, Error>) -> Void
    ) {
        authAPIService.confirmSignUp(for: username, with: confirmationCode) { result in
            switch result {
            case let .success(data):
                let decodedResult: Result<Bool, Error> = decode(from: data)
                complete(decodedResult)
            case let .failure(error):
                complete(.failure(error))
            }
        }
    }
    
}
