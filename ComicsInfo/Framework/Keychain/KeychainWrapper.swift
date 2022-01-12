//
//  KeychainWrapper.swift
//  ComicsInfo
//
//  Created by Aleksandar Dinic on 09/01/2022.
//

import Foundation

struct KeychainWrapper {
    
    func store(_ password: String,
      for account: String,
      service: String
    ) throws {
        guard !password.isEmpty else {
            try deletePassword(for: account, service: service)
            return
        }
        
        guard let passwordData = password.data(using: .utf8) else {
            throw KeychainError.badData
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service,
            kSecValueData as String: passwordData
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            break
        case errSecDuplicateItem:
            try update(
                password,
                for: account,
                service: service
            )
        default:
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    func deletePassword(for account: String, service: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]

        let status = SecItemDelete(query as CFDictionary)
        switch status {
        case errSecSuccess, errSecItemNotFound:
            break
        default:
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    func update(
        _ password: String,
        for account: String,
        service: String
    ) throws {
        guard let passwordData = password.data(using: .utf8) else {
            return
        }
      
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecAttrService as String: service
        ]

        let attributes: [String: Any] = [
            kSecValueData as String: passwordData
        ]

        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        switch status {
        case errSecSuccess:
            break
        case errSecItemNotFound:
            throw KeychainError.noPassword
        default:
            throw KeychainError.unhandledError(status: status)
        }
    }
    
}
