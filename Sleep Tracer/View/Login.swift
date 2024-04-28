//
//  Login.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 3/31/24.
//

import SwiftUI

struct Login: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @FocusState private var emailFieldIsFocused: Bool
    @State private var isLoggedIn: Bool = false
    @State private var message: String = "Enter email and password."

    var body: some View {

        let authManager = AuthenticationManager.shared
            
            VStack{
                HStack {
                    Image("Sleep Tracer")
                    Spacer()
                    Image("Sleep Tracer Icon Transparent")
                }
                
                Spacer()
                
                TextField("Email Address", text: $email)
                    .focused($emailFieldIsFocused)
                    .onSubmit {
                        //                        validate(email: useremail)
                    }
                    .textFieldStyle()
                
                SecureField("Enter a password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .scrollContentBackground(.hidden)
                
                    .textFieldStyle()
                
                
                
                Text(message)
                    .foregroundStyle(Color.white)
                Spacer()
                Spacer()
                HStack {
                    Spacer()
                    Button("Login") {
                        // Perform login action
                        let isLoggedIn = authManager.login(email: email, password: password)
                        if isLoggedIn == true {
                            print("isLoggedIn = true")
                            
                            
                        } else {
                            message = "Wrong eMail address or password"
                            
                        }
                    }
                    .foregroundStyle(Color("Button Color"))
                    
                    Spacer()
                    Button("Register") {
                        // Navigate to Registration view
                        self.isLoggedIn = false
                    }.sheet(isPresented: $isLoggedIn, content: {
                        Registration()
                    })
                    .foregroundStyle(Color("Button Color"))
                    Spacer()
                }
                
                
                
            }
            .background(Color.black)
        }
    
}

#Preview {
    Login()
}
