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
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
