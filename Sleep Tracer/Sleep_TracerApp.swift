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
        WindowGroup {
            TabView {
                Login()
                    .tabItem {
                     Label("Login", systemImage: "square.and.arrow.up")
                    }
                    .toolbarBackground(.visible, for: .tabBar) // since it's hidden by default
                    .toolbarBackground(Color.black, for: .tabBar) // toolbarBackground is per tabItem, not per TabView
                ResperatoryView()
                    .tabItem {
                        Label("Resperatory Rate", systemImage: "lungs.fill")
                            
                    }
                    .toolbarBackground(Color.black, for: .tabBar) // toolbarBackground is per tabItem, not per TabView
                    
            }
            .toolbarColorScheme(.light, for: .tabBar)
        }
    }
}
