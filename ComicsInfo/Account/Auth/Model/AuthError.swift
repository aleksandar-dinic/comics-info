//
//  AuthError.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 19/12/2021.
//

import enum Amplify.AuthError
import enum Amplify.AuthSignInStep
import enum AWSCognitoAuthPlugin.AWSCognitoAuthError
import Foundation

enum AuthError: Error {
    
    case userDoesNotExist
    case usernameExists
    case notAuthorized
    case signUpIsNotConfirmed
    case limitExceeded
    case codeMismatch
    case codeExpired
    case invalidParameter(_ message: String)
    case unknown
    
}

extension AuthError {
    
    init(from error: Amplify.AuthError?) {
        guard let error = error else {
            self = .unknown
            return
        }
        switch error {
        case let .service(message, _, err):
            switch err {
            case let .some(val) where val as? AWSCognitoAuthError == .userNotFound:
                self = .userDoesNotExist
            case let .some(val) where val as? AWSCognitoAuthError == .limitExceeded:
                self = .limitExceeded
            case let .some(val) where val as? AWSCognitoAuthError == .usernameExists:
                self = .usernameExists
            case let .some(val) where val as? AWSCognitoAuthError == .codeMismatch:
                self = .codeMismatch
            case let .some(val) where val as? AWSCognitoAuthError == .codeExpired:
                self = .codeExpired
            case let .some(val) where val as? AWSCognitoAuthError == .invalidParameter:
                self = .invalidParameter(message)
            default:
                self = .unknown
            }
        case .notAuthorized:
            self = .notAuthorized
        default:
            self = .unknown
        }
    }
    
    init(from signInStep: Amplify.AuthSignInStep) {
        switch signInStep {
        case .confirmSignUp:
            self = .signUpIsNotConfirmed
        default:
            self = .unknown
        }
    }
    
}

extension AuthError: LocalizedError {
        
    var errorDescription: String? {
        String.localized(self)
    }
    
    var key: String {
        switch self {
        case .userDoesNotExist:
            return "UserDoesNotExist"
        case .usernameExists:
            return "UsernameExists"
        case .notAuthorized:
            return "NotAuthorized"
        case .signUpIsNotConfirmed:
            return "SignUpIsNotConfirmed"
        case .limitExceeded:
            return "LimitExceeded"
        case .codeMismatch:
            return "CodeMismatch"
        case .codeExpired:
            return "CodeExpired"
        case .invalidParameter:
            return "InvalidParameter"
        case .unknown:
            return "Unknown"
        }
    }
    
    var value: String {
        switch self {
        case .userDoesNotExist:
            return "User does not exist."
        case .usernameExists:
            return "Username already exists"
        case .notAuthorized:
            return "Incorrect username or password."
        case .signUpIsNotConfirmed:
            return "You need to verify your account."
        case .limitExceeded:
            return "Attempt limit exceeded, please try after some time."
        case .codeMismatch:
            return "Invalid verification code provided, please try again."
        case .codeExpired:
            return "Verification code has expired."
        case let .invalidParameter(message):
            return message
        case .unknown:
            return "Something went wrong, please try again."
        }
    }
    
    var comment: String {
        switch self {
        case .userDoesNotExist:
            return "User does not exist."
        case .usernameExists:
            return "Username already exists"
        case .notAuthorized:
            return "Access is denied."
        case .signUpIsNotConfirmed:
            return "Account is not verified."
        case .limitExceeded:
            return "Attempt limit exceeded, please try after some time."
        case .codeMismatch:
            return "Invalid verification code provided, please try again."
        case .codeExpired:
            return "Verification code has expired."
        case .invalidParameter:
            return "Invalid parameter"
        case .unknown:
            return "Something went wrong."
        }
    }
        
}
