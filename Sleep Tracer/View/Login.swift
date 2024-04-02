//
//  Login.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 3/31/24.
//

import SwiftUI

struct Login: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @FocusState private var emailFieldIsFocused: Bool
    
    
    var body: some View {
        VStack{
            HStack {
                Image("Sleep Tracer")
                Spacer()
                Image("Sleep Tracer Icon Transparent")
            }
            
            Spacer()
            TextField("User Name", text: $username)
                .focused($emailFieldIsFocused)
                .onSubmit {
                    //                        validate(name: username)
                }
                .frame(minWidth: 250)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .fixedSize(horizontal: true, vertical: false)
            
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .background(Color.white)
            
            SecureField("Enter a password", text: $password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
                .frame(minWidth: 250)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .fixedSize(horizontal: true, vertical: false)
            
                .focused($emailFieldIsFocused)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .background(Color.white)
                .scrollContentBackground(.hidden)
            
            Spacer()
            Spacer()
            Spacer()
            
        }
        .background(Color.black)
    }
}

#Preview {
    Login()
}
