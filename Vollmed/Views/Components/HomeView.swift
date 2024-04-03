//
//  HomeView.swift
//  Vollmed
//
//  Created by Elisangela Pethke on 31.10.23.
//
import SwiftUI

struct HomeView: View {
    
    let service = WebService()
    
    @State private var specialists: [Specialist] = []
    
    func getSpecialists() async {
        do {
            if let specialists = try await service.getAllSpecialists() {
                print(specialists)
                self.specialists = specialists
            }
        } catch {
            print("Ocorreu um erro ao obter os especialistas: \(error)")
        }
    }

    func logout() async {
        
        do{
            let logoutSuccefull = try await service.logoutPatient()
            if logoutSuccefull {
                KeychainHelper.remove(for: "app-vollmed-token")
                KeychainHelper.remove(for: "app-vollmed-patient-id")
            }
            
        } catch {
            print("Ocorreu um erro no logout \(error)")
        }
    
    }
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.vertical, 32)
                Text("Boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color("LightBlue"))
                Text("Veja abaixo os especialistas da Vollmed disponíveis e marque já a sua consulta!")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.accentColor)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 16)
                ForEach(specialists) { specialist in
                    SpecialistCardView(specialist: specialist)
                        .padding(.bottom, 8)
                }
            }
            .padding(.horizontal)
        }
        .padding(.top)
        
        .onAppear {
            Task {
                await getSpecialists()
            }
        }
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    Task {
                        await logout()
                    }
                }, label: {
                    HStack(spacing: 2){
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Logout")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)                    }
                })
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
