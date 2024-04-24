//
//  TextFieldStyle.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/22/24.
//

import Foundation
import SwiftUI

extension View {
    func textFieldStyle() -> some View {
        self.frame(minWidth: 250)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .fixedSize(horizontal: true, vertical: false)
        
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .background(Color.white)
            .textFieldStyle(.roundedBorder)

    }
    
    func credentialFieldStyle() -> some View {
        self.disableAutocorrection(true)
            .autocapitalization(.none)
//            .scrollContentBackground(.hidden)

    }
    
}
