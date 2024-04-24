//
//  Login.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 3/31/24.
//

import SwiftUI

struct Login: View {
    
    @State private var useremail: String = ""
    @State private var password: String = ""
    @FocusState private var emailFieldIsFocused: Bool
    @State private var isModal: Bool = false

    var body: some View {

        VStack{
            HStack {
                Image("Sleep Tracer")
                Spacer()
                Image("Sleep Tracer Icon Transparent")
            }

            Spacer()
            
            TextField("User Name", text: $useremail)
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
                    //                
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
