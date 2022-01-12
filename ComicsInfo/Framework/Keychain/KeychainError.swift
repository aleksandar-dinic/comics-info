//
//  KeychainError.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/01/2022.
//

import Foundation

enum KeychainError: Error {
    
    case badData
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)

}
