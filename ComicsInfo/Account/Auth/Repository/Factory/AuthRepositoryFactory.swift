//
//  AuthRepositoryFactory.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 18/12/2021.
//

import Foundation

protocol AuthRepositoryFactory {
    
    var authAPIService: AuthAPIService { get }
    
    func makeAuthRepository() -> AuthRepository
    
}

extension AuthRepositoryFactory {
    
    func makeAuthRepository() -> AuthRepository {
        AuthRepository(authAPIService: authAPIService)
    }
    
}
