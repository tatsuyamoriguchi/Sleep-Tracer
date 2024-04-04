//
//  ContentView.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/4/24.
//

import SwiftUI


struct ContentView: View {

    var body: some View {
                    
        @State var loggedIn: Bool = true
        Group {
            if loggedIn == true {
                TabView {
                    Home()
                        .tabItem {
                            Label("Home", systemImage: "square.and.arrow.up")
                        }
                        .toolbarBackground(.visible, for: .tabBar) // since it's hidden by default
                        .toolbarBackground(Color.black, for: .tabBar) // toolbarBackground is per tabItem, not per TabView
                    
                    ResperatoryView()
                        .tabItem {
                            Label("Resperatory Rate", systemImage: "lungs.fill")
                        }
                    
                    Login()
                        .tabItem {
                            Label("Logout", systemImage: "square.and.arrow.up")
                        }
                        .toolbarBackground(Color.black, for: .tabBar) // toolbarBackground is per tabItem, not per TabView
                        .onTapGesture {
                            loggedIn = false
                        }
                    
                }
                .toolbarColorScheme(.light, for: .tabBar)

            } else {
                Login()
            }
        }
    }
}


#Preview {
    ContentView()
}
