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
    @State private var message: String = "Enter email and password."
    @State private var showRegistration = false
    @State private var showContentView: Bool = false
    @ObservedObject var authManager = AuthenticationManager()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
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
                        if authManager.login(email: email, password: password) == false {
                            message = "Wrong eMail address or password"
                        } else {
                            presentationMode.wrappedValue.dismiss()
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
        .background(Color.black)
    }
    
}

#Preview {
    Login()
}
