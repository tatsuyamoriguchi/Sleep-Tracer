//
//  Validation.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 5/9/24.
//

import Foundation

struct Validation {
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = #"^(?=.*[!@#$%^&*()_+\\-={}[\]|;:'",.<>?])[A-Za-z0-9!@#$%^&*()_+\\-={}[\]|;:'",.<>?]{8,}$"#
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
}
