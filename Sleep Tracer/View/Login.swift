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
    @State private var isModal: Bool = false

    var body: some View {

        let authManager = AuthenticationManager.shared
        
        VStack{
            HStack {
                Image("Sleep Tracer")
                Spacer()
                Image("Sleep Tracer Icon Transparent")
            }

            Spacer()
            
            TextField("User Name", text: $email)
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


            Spacer()
            Spacer()
            Spacer()
            HStack {
                Spacer()
                Button("Login") {
                    // Perform login action
                    authManager.login(email: email, password: password)
                }
                .foregroundStyle(Color("Button Color"))
                
                Spacer()
                Button("Register") {
                    // Navigate to Registration view
                    self.isModal = true
                }.sheet(isPresented: $isModal, content: {
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
