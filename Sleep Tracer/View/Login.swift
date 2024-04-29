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
    @State private var showRegistration = false
    
    var body: some View {
        
        let authManager = AuthenticationManager.shared
        
        VStack{
            if isLoggedIn == true {
                ContentView()
            } else {
                
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
                        isLoggedIn = authManager.login(email: email, password: password)
                        if isLoggedIn == false {
                            
                            message = "Wrong eMail address or password"
                            
                        }
                    }
                    .foregroundStyle(Color("Button Color"))
                    
                    Spacer()
                    Button("Register") {
                        // Navigate to Registration view
                        showRegistration.toggle()
                    }.sheet(isPresented: $showRegistration) {
                        Registration()
                    }
                    .foregroundStyle(Color("Button Color"))
                    Spacer()
                }
                
            }
            
        }
        .background(Color.black)
    }
    
}

#Preview {
    Login()
}
