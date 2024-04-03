//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Elisangela Pethke on 14.02.24.
//

import SwiftUI

struct MyAppointmentsView: View {
    
    let service = WebService()
    @State private var appointments: [Appointment]? = []
    
    func getAllAppointments() async {
        
        guard let patientID = KeychainHelper.get(for: "app-vollmed-patient-id") else{
            return
        }
        do {
            let appointments = try await
            service.getAllAppointmentFromPatient(patientID:patientID)
            self.appointments = appointments
            
            
        } catch {
            print("Ocorreu um erro ao agendar consulta: \(error)")
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
                    if let appointments = appointments, !appointments.isEmpty {
                        ForEach(appointments) { appointment in
                            SpecialistCardView(specialist: appointment.specialist, appointment: appointment)
                        }
                    } else {
                        Text("Não há Nenhuma consultas agendadas no Momento!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.accentColor)
                            .multilineTextAlignment(.center)
                            .padding(.top,300)
                    }
                }
    
        .navigationTitle("Minhas Consultas")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .onAppear{
            Task{
                await getAllAppointments()
            }
        }
        
    }
}

#Preview {
    MyAppointmentsView()
}
