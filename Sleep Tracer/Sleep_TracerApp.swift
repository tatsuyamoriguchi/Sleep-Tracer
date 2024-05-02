//
//  Sleep_TracerApp.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/6/22.
//

import SwiftUI

@main


struct Sleep_TracerApp: App {
    @ObservedObject var authManager = AuthenticationManager()

    var body: some Scene {
        
        WindowGroup {
            Group {
                if authManager.isLoggedIn == true {
                    ContentView(authManager: authManager)
                } else {
                    Login(authManager: authManager)
                }
            }
        }
    }
}
