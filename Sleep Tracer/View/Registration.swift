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
                // Perform registration action
                if AuthenticationManager.shared.register(email: email, password: password, confirmPassword: confirmPassword) == true {
                    print("registration completed")
                    presentationMode.wrappedValue.dismiss()
                    
                } else {
                    message = "Confirm Password doesn't match with Password. Try it again."
                    email = ""
                    password = ""
                    confirmPassword = ""
                    
                    print("Issue in AuthenticationManager.shared.register(email: email, password: password, confirmPassword)")
                    
                }
            }
            .foregroundStyle(Color("Button Color"))
        }
        .presentationDetents([.medium])
        .background(Color.clear)
    }
}


#Preview {
    Registration()
}
