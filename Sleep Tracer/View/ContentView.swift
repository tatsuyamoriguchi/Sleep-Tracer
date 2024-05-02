//
//  ContentView.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/4/24.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var authManager = AuthenticationManager()
    
    var body: some View {
        
       Group {
            
            if authManager.isLoggedIn {
                ContentViewWithTabs(authManager: authManager)
            } else {
                Login(authManager: authManager)
            }
           
        }
    }
}
    
 
struct ContentViewWithTabs: View {
    @ObservedObject var authManager: AuthenticationManager
    
    var body: some View {
        
        
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

            Text("Confirm to Logout")
            .tabItem {
                Label("Logout",  systemImage: "square.and.arrow.up")
            }
            .onTapGesture {
                    authManager.isLoggedIn = false
            }
            .toolbarBackground(Color.black, for: .tabBar)
        }
        .toolbarColorScheme(.light, for: .tabBar)
        
    }
}

#Preview {
    ContentView()
}
