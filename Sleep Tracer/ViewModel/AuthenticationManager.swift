//
//  AuthenticationManager.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/23/24.
//

import Foundation
import Security

class AuthenticationManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    //    static var isLoggedIn: Bool = false

    static let shared = AuthenticationManager()
    
    private init() {}
    
    func register(email: String, password: String, confirmPassword: String) -> Bool {
        // Perform registration logic
        // Call authentification service to register a user
        if password != confirmPassword {
            print("password doesn't match with confirmPassword.")
            self.isLoggedIn = false
            return self.isLoggedIn
        }
            
        
        
        do {
            try Keychain.save(email: email, password: password)
            self.isLoggedIn = true
            print("User registered with email: \(email) and password: \(password)")
        } catch {
            self.isLoggedIn = false
            print("Error saving user credentials: \(error.localizedDescription)")
        }
        return self.isLoggedIn
    }
    
    func login(email: String, password: String) -> Bool {
        // Perform login logic.
        // Call authentification service to login a user. Use DispatchQueue.main.sync { if calling external API
        if email == email, password == password {
            do {
                let retrievedPassword = try Keychain.shared.retrievePassword(forEmail: email)
                if retrievedPassword == password {
                    self.isLoggedIn = true
                    
                    print("isLoggedIn = \(self.isLoggedIn)")
                    print("Passowrd matched")
                } else {
                    self.isLoggedIn = false
                    print("isLoggedIn = \(self.isLoggedIn)")
                    print("Password unmatched")
                }
            } catch {
                print("Keychain.shared.retrievePassword(forEmail: email) returned an error.")
            }
        }
        return self.isLoggedIn
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
