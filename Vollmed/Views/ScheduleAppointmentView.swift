//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Elisangela Pethke on 23.01.24.
//


import SwiftUI

struct ScheduleAppointmentView: View {
    
    let service = WebService()
    
    var specialistID: String
    var isRescheduleView: Bool
    var appointmentID: String?
    
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var isAppointmentScheduled = false 
    @Environment(\.presentationMode) var presentationMode
    
    init(specialistID: String, isRescheduleView: Bool = false, appointmentID: String? = nil) {
        self.specialistID = specialistID
        self.isRescheduleView = isRescheduleView
        self.appointmentID = appointmentID
    }
    
    func rescheduleAppointment() async {
        guard let appointmentID = appointmentID else {
            print("Houve um erro ao obter o ID da consulta")
            return
        }
        
        do {
            if let _ = try await service.rescheduleAppointment(appointmentID: appointmentID, date: selectedDate.convertToString()) {
                      
                      isAppointmentScheduled = true
            } else {
                
                isAppointmentScheduled = false
            }
            
        } catch {
            isAppointmentScheduled = false
            print("Ocorreu um erro ao agendar consulta: \(error)")
        }
        showAlert = true
    }
    
    func scheduleAppointment() async {
        guard let patientID = KeychainHelper.get(for: "app-vollmed-patient-id") else{return}
        
        do {
            _ = try await service.scheduleAppointment(specialistID: specialistID, patientID: patientID, date: selectedDate.convertToString())
            isAppointmentScheduled = true
            
        } catch {
            isAppointmentScheduled = false
            print("Ocorreu um erro ao agendar consulta: \(error)")
        }
        showAlert = true
    }
    
    var body: some View {
        VStack {
            Text("Selecione a Data e Horário da Consulta")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            DatePicker("Escolha a Data da Consulta", selection: $selectedDate, in: Date()...)
                .datePickerStyle(.graphical)
            
            Button(action: {
                Task {
                    if isRescheduleView {
                        await rescheduleAppointment()
                    } else {
                        await scheduleAppointment()
                    }
                    
                }
            }, label: {
                ButtonView(text: isRescheduleView ? "Reagendar Consulta" : "Agendar Consulta")
            })
            
        }
        .padding()
        .navigationTitle(isRescheduleView ? "Reagendar Consulta" : "Agendar Consulta")
        .navigationBarTitleDisplayMode(.large)
        .onAppear{
            UIDatePicker.appearance().minuteInterval = 15
        }
        .alert("Sucesso!", isPresented: $showAlert) {
            Button(action: {presentationMode.wrappedValue.dismiss()}, label: {
                Text("OK")
            })
        } message: {
            if isAppointmentScheduled {
                Text("A Consulta foi \(isRescheduleView ? "Reagendada" : "Agendada") com Sucesso")
            } else {
                Text("Algo deu errado ao \(isRescheduleView ? "Reagendar" : "Agendar") sua consulta, por favor tente novamente, ou entre em contato com a clínica.")
            }
        }
        
    }
}



#Preview {
    ScheduleAppointmentView(specialistID: "123")
}
