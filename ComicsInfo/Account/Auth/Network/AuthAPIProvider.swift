//
//  AuthAPIProvider.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 18/12/2021.
//

import Amplify
import AWSCognitoAuthPlugin
import Foundation
import UIKit

final class AuthAPIProvider: AuthAPIService {
    
    func getCurrentUser() -> User? {
        guard let user = Amplify.Auth.getCurrentUser() else {
            return nil
        }
        return User(
            identifier: user.userId,
            username: user.username,
            email: nil,
            nickname: nil
        )
    }
    
    func getUserAttributes(
        onComplete complete: @escaping (Result<[UserAttribute], Error>) -> Void
    ) {
        Amplify.Auth.fetchUserAttributes { result in
            switch result {
            case let .success(attributes):
                var userAttributes = [UserAttribute]()
                
                for attribute in attributes {
                    if attribute.key == .email {
                        userAttributes.append(.email(attribute.value))
                    } else if attribute.key == .nickname {
                        userAttributes.append(.nickname(attribute.value))
                    } else if attribute.key == .unknown("identities"),
                                attribute.value.contains("SignInWithApple") {
                        userAttributes.append(.authProvider(.apple))
                    }
                }
                
                complete(.success(userAttributes))
            case let .failure(error):
                complete(.failure(AuthError(from: error)))
            }
        }
    }
    
    func signIn(
        username: String,
        password: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            case let .success(authResult):
                if authResult.isSignedIn {
                    complete(.success(()))
                } else {
                    complete(.failure(AuthError(from: authResult.nextStep)))
                }
            case let .failure(error):
                complete(.failure(AuthError(from: error)))
            }
        }
    }
    
    func signInWithApple(
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        guard
            let scene = UIApplication.shared.connectedScenes.first,
            let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
            let window = windowSceneDelegate.window as? UIWindow
        else { return complete(.failure(AuthError.unknown)) }
        
        Amplify.Auth.signInWithWebUI(for: .apple, presentationAnchor: window) { result in
            switch result {
            case let .success(authResult):
                if authResult.isSignedIn {
                    complete(.success(()))
                } else {
                    complete(.failure(AuthError(from: authResult.nextStep)))
                }
            case let .failure(error):
                complete(.failure(AuthError(from: error)))
            }
        }
    }
    
    func resetPassword(
        for username: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        Amplify.Auth.resetPassword(for: username) { result in
            switch result {
            case .success:
                complete(.success(()))
            case let .failure(error):
                complete(.failure(AuthError(from: error)))
            }
        }
    }
    
    func confirmResetPassword(
        for username: String,
        with newPassword: String,
        confirmationCode: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        Amplify.Auth.confirmResetPassword(
            for: username,
            with: newPassword,
            confirmationCode: confirmationCode
        ) { result in
            switch result {
            case .success:
                complete(.success(()))
            case let .failure(error):
                complete(.failure(AuthError(from: error)))
            }
        }
    }
    
    func changePassword(
        oldPassword: String,
        newPassword: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        Amplify.Auth.update(oldPassword: oldPassword, to: newPassword) { result in
            switch result {
            case .success:
                complete(.success(()))
            case let .failure(error):
                complete(.failure(AuthError(from: error)))
            }
        }
    }
    
    func signUp(
        username: String,
        email: String,
        password: String,
        onComplete complete: @escaping (Result<Bool, Error>) -> Void
    ) {
        let userAttributes = [
            AuthUserAttribute(.email, value: email)
        ]
        
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: username, password: password, options: options) { result in
            switch result {
            case let .success(signUpResult):
                complete(.success(signUpResult.isSignupComplete))
            case let .failure(error):
                complete(.failure(AuthError(from: error)))
            }
        }
    }
    
    func confirmSignUp(
        for username: String,
        with confirmationCode: String,
        onComplete complete: @escaping (Result<Bool, Error>) -> Void
    ) {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case let .success(confirmResult):
                complete(.success(confirmResult.isSignupComplete))
            case let .failure(error):
                complete(.failure(AuthError(from: error)))
            }
        }
    }
    
    func resendSignUpCode(
        for username: String,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        Amplify.Auth.resendSignUpCode(for: username) { result in
            switch result {
            case .success:
                complete(.success(()))
            case let .failure(error):
                complete(.failure(AuthError(from: error)))
            }
        }
    }
    
    func signOut(
        globaly: Bool,
        onComplete complete: @escaping (Result<Void, Error>) -> Void
    ) {
        Amplify.Auth.signOut(options: .init(globalSignOut: globaly)) { result in
            switch result {
            case .success:
                complete(.success(()))
            case let .failure(error):
                complete(.failure(AuthError(from: error)))
            }
        }
    }
    
}
