//
//  TextFieldStyle.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/22/24.
//

import Foundation
import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 250)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .fixedSize(horizontal: true, vertical: false)
        
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .background(Color.white)
            .textFieldStyle(.roundedBorder)
        
    }
}


struct CredentialFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .autocapitalization(.none)
    }
    
}
