//
//  ContentView.swift
//  Vollmed
//
//  Created by Elisangela Pethke on 31.10.23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("token") var token: String = ""
    
    var body: some View {
        
        if token.isEmpty {
            NavigationStack {
                SignInView()
            }
        } else {
            TabView{
                NavigationStack{
                    HomeView()
                }
                .tabItem {
                    Label(
                        title: { Text("Home") },
                        icon: { Image(systemName: "house") }
                    )
                }
                
                NavigationStack{
                    MyAppointmentsView()
                }
                .tabItem {
                    Label(
                        title: { Text("Minhas Consultas") },
                        icon: { Image(systemName: "calendar") }
                    )
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
