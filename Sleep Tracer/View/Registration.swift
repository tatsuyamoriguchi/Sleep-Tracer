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
    @FocusState private var emailFieldIsFocused: Bool
    
    
    
    var body: some View {
        @Environment(\.presentationMode) var presentationMode

        VStack{
            Spacer()
            HStack {
                Text("Registration")
                    .font(.largeTitle)
            }
            Spacer()
            
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
                if AuthenticationManager.shared.register(email: email, password: password) == true {
                    print("registration completed")
                    presentationMode.wrappedValue.dismiss()
                    
                } else {
                    print("Issue in AuthenticationManager.shared.register(email: email, password: password)")
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
