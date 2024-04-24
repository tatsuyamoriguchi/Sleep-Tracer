//
//  AuthenticationManager.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/23/24.
//

import Foundation
import Security

class AuthenticationManager {
    // why class, instead of struct?
    static let shared = AuthenticationManager()
    
    func register(email: String, password: String) {
        // Perform registration logic
        // Call authentification service to register a user
        do {
            try Keychain.save(email: email, password: password)
            print("User registred with email: \(email) and password: \(password)")
        } catch {
            print("Error saving user credentials: \(error.localizedDescription)")
        }
    }
    
    func login(email: String, password: String) {
        // Perform login logic.
        // Call authentification service to login a user.
    }
    
    func logout() {
        // Perform logout logic
        // Clear user session data
    }
}

struct Keychain {
    static let service = "SleepTracer"
    
    static func save(email: String, password: String) throws {
        guard let passwordData = password.data(using: .utf8) else {
            throw KeychainError.dataConversionError
        }
        let query: [String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: email,
            kSecValueData as String: passwordData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            throw KeychainError.unhandledError(status: status)
        }
    
        
    }
}

enum KeychainError: Error {
    case dataConversionError
    case unhandledError(status: OSStatus)
}
