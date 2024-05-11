//
//  ContentView.swift
//  Vollmed
//
//  Created by Elisangela Pethke on 31.10.23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var authManager = AuthenticationManager.shared
    
    var body: some View {
        
        if authManager.token == nil {
            NavigationStack {
                SignInView()
            }
        } else {
            TabView {
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    Label(
                        title: { Text("Home") },
                        icon: { Image(systemName: "house") }
                    )
                }
                
                NavigationStack {
                    MyAppointmentsView()
                }
                .tabItem {
                    Label(
                        title: { Text("Minhas consultas") },
                        icon: { Image(systemName: "calendar") }
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
