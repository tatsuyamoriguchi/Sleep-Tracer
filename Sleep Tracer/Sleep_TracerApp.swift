//
//  Sleep_TracerApp.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/6/22.
//

import SwiftUI

@main


struct Sleep_TracerApp: App {
    var body: some Scene {

        // Temporal property to show Login() or ContentView()
        var loggedIn: Bool = true
        
        WindowGroup {
            Group {
                if loggedIn == true {
                    ContentView()
                } else {
                    Login()
                }
            }
        }
    }
}
