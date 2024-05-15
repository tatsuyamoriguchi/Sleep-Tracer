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

    static let shared = AuthenticationManager()
        
    
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
}

struct Keychain {
    
    static let shared = Keychain()
    static let service = "SleepTracer"
    
    // Function to check if a user account already exists in Keychain
    static func doesAnyUserExist() -> Bool {
        // Define query parameters
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true
        ]
        
        // Try to fetch existing item from Keychain
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        print("doesAnyUserExist SecItemCopyMatching status: \(status)")
        
        // Check if user account exists or not
        if status == errSecSuccess {
            return true
        } else if status == errSecItemNotFound {
            return false
        } else {
            print("Keychain error: \(status)")
            return false
        }
    }


    static func save(email: String, password: String) throws {
        guard let passwordData = password.data(using: .utf8) else {
            throw KeychainError.dataConversionError
        }
        
        var cfError: Unmanaged<CFError>?
        
        guard let accessControl = SecAccessControlCreateWithFlags(nil, kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly, .biometryCurrentSet, &cfError) else {
            if let error = cfError {
                  print("Error creating access control:", error.takeRetainedValue() as Error)
              } else {
                  print("Unknown error creating access control")
              }
            return
        }
        
        let query: [String:Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: email,
            kSecValueData as String: passwordData,
            kSecAttrAccessControl as String: accessControl
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
        print("retrievePassword SecItemCopyMatching status: \(status)")
            
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
