//
//  Dashboard.swift
//  Sleep Tracer
//
//  Created by Tatsuya Moriguchi on 4/3/24.
//

import SwiftUI

struct Home: View {

    var body: some View {
        
        
        Text("Home - Dashboard")
        
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
            
        }
        .toolbarColorScheme(.light, for: .tabBar)
    }
}

#Preview {
    Home()
}
