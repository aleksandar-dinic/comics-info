//
//  AuthAPIService.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 18/12/2021.
//

import Foundation

protocol AuthAPIService {
    
    func getCurrentUser() -> User?
    
    func getUserAttributes(
        onComplete complete: @escaping (Result<[UserAttribute], Error>) -> Void
    )
    
    func getAccessToken(
        onComplete complete: @escaping (Result<String, Error>) -> Void
    )
    
    func signIn(
        username: String,
        password: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    )
    
    func signInWithApple(
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    )
    
    func resetPassword(
        for username: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    )
    
    func confirmResetPassword(
        for username: String,
        with newPassword: String,
        confirmationCode: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    )
    
    func changePassword(
        oldPassword: String,
        newPassword: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    )
    
    func signUp(
        username: String,
        email: String,
        password: String,
        onComplete complete: @escaping (Result<Bool, Error>) -> Void
    )
    
    func confirmSignUp(
        for username: String,
        with confirmationCode: String,
        onComplete complete: @escaping (Result<Bool, Error>) -> Void
    )
    
    func resendSignUpCode(
        for username: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    )
    
    func signOut(
        globaly: Bool,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    )
    
}
