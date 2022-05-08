//
//  LoadingState.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 27/12/2021.
//

import Foundation

enum LoadingState<Value> {
 
    case idle
    case loading(currentValue: Value?)
    case failed(Error)
    case loaded(Value)
    
    func isLoading() -> Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    var errorMessage: String {
        guard case let .failed(error) = self, let authError = error as? AuthError else {
            return AuthError.unknown.localizedDescription
        }
        return authError.localizedDescription
    }
    
    var isSignedOut: Bool {
        guard
            case let .failed((error as AuthError)) = self,
            case AuthError.signedOut = error
        else { return false }
        
        return true
    }
    
}

extension LoadingState: Equatable {
    
    static func == (lhs: LoadingState<Value>, rhs: LoadingState<Value>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.failed, .failed):
            return true
        case (.loaded, .loaded):
            return true
        default:
            return false
        }
    }

}
