//
//  Registration.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/21/24.
//

import SwiftUI

struct Registration: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var message = "Enter your email and password below."
    @FocusState private var emailFieldIsFocused: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var authManager = AuthenticationManager.shared
    
    var body: some View {
        
        
        VStack{
            Spacer()
            HStack {
                Text("Registration")
                    .font(.largeTitle)
            }
            Spacer()
            Text(message)
            Spacer()
            TextField("eMail Address", text: $email)
                .focused($emailFieldIsFocused)
                .onSubmit {
                    //                        validate(name: username)
                }
                .textFieldStyle()
            
            SecureField("Enter a password", text: $password)
                .credentialFieldStyle()
                .textFieldStyle()
            
            SecureField("Confirm Password", text: $confirmPassword)
                .credentialFieldStyle()
                .textFieldStyle()
            
            Spacer()
            Spacer()
            Spacer()
            
            Button("Register") {
                
                // Perform email and password validation
                if Validation().isValidEmail(email) == false {
                    message = "email is not in valid format."
                    email = ""
                } else if password != confirmPassword {
                    message = "Confirm Password doesn't match with Password. Try it again."
                    password = ""
                    confirmPassword = ""
                } else if Validation().isValidPassword(password) == false {
                    message = "password is not in valid format. Please use 8 characters or more, one special character or more, one numebr or more, and one capital letter or more."
                    password = ""
                    confirmPassword = ""
                } else {
                    // Check if a user already exists.
                    if Keychain.doesAnyUserExist() == true {
                        message = "A user already exists. Only one user per a device is allowed."
                        email = ""
                        password = ""
                        confirmPassword = ""
                        
                        
                    } else {
                        // Perform registration action
                        registrationAction(emailGiven: email, passwordGiven: password, confirmPasswordGiven: confirmPassword)
                        
                    }
                    
                }
            }
            .foregroundStyle(Color("Button Color"))
        }
        .presentationDetents([.medium])
        .background(Color.clear)
    }
}

extension Registration {
    
//    func validFormat(emailGiven: String, passwordGiven: String) {
//        if Validation().isValidEmail(emailGiven) == false {
//            message = "email is not in valid format."
//            email = ""
//        }
//    }
    
    func registrationAction(emailGiven: String, passwordGiven: String, confirmPasswordGiven: String) {
        let isValid = authManager.register(email: emailGiven, password: passwordGiven, confirmPassword: confirmPasswordGiven)
        print(isValid)
        
        if isValid == true {
            print("registration completed")
            presentationMode.wrappedValue.dismiss()
            
        } else {
            message = "Unable to register. That user account already exists."
            email = ""
            password = ""
            confirmPassword = ""
            
            
        }
        
        
    }
}


#Preview {
    Registration()
}
