//
//  AuthenticationManager.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/23/24.
//

import Foundation
import Security

class AuthenticationManager {

    static let shared = AuthenticationManager()
    static var isLoggedIn: Bool = false
    
    private init() {}
    
    func register(email: String, password: String, confirmPassword: String) -> Bool {
        // Perform registration logic
        // Call authentification service to register a user
        if password != confirmPassword {
            print("password doesn't match with confirmPassword.")
            AuthenticationManager.isLoggedIn = false
            return AuthenticationManager.isLoggedIn
        }
            
        
        
        do {
            try Keychain.save(email: email, password: password)
            AuthenticationManager.isLoggedIn = true
            print("User registred with email: \(email) and password: \(password)")
        } catch {
            AuthenticationManager.isLoggedIn = false
            print("Error saving user credentials: \(error.localizedDescription)")
        }
        print("Hello")
        return AuthenticationManager.isLoggedIn
    }
    
    func login(email: String, password: String) {
        // Perform login logic.
        // Call authentification service to login a user. Use DispatchQueue.main.sync { if calling external API
        if email == email, password == password {
            // Save user credentials to Keychain
            do {
                // nonono, retrieve it, not save it!!!
                let retrievedPassword = try Keychain.shared.retrievePassword(forEmail: email)
                
                if retrievedPassword == password {
                    AuthenticationManager.isLoggedIn = true
                    print("isLoggedIn = \(AuthenticationManager.isLoggedIn)")
                    print("Passowrd matched")
                } else {
                    AuthenticationManager.isLoggedIn = false
                    print("isLoggedIn = \(AuthenticationManager.isLoggedIn)")
                    print("Password unmatched")
                }
            } catch {
                print("Unable to save credentials.")
            }
            
        }



    }
    
    func logout() {
        // Perform logout logic
        // Clear user session data
    }
}

struct Keychain {
    
    static let shared = Keychain()
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
    
    func retrievePassword(forEmail email: String) throws -> String? {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: Keychain.service,
                kSecAttrAccount as String: email,
                kSecMatchLimit as String: kSecMatchLimitOne,
                kSecReturnData as String: kCFBooleanTrue!
            ]
            
            var result: AnyObject?
            let status = SecItemCopyMatching(query as CFDictionary, &result)
            
            guard status == errSecSuccess else {
                if status == errSecItemNotFound {
                    print("No password found for the given email")
                    return nil
                } else {
                    throw KeychainError.unhandledError(status: status)
                }
            }
            
            guard let passwordData = result as? Data else {
                throw KeychainError.unexpectedDataError
            }
            
            guard let password = String(data: passwordData, encoding: .utf8) else {
                throw KeychainError.dataConversionError
            }
            
            return password
        }}

enum KeychainError: Error {
    case dataConversionError
    case unhandledError(status: OSStatus)
    case unexpectedDataError
}
