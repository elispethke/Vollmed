//
//  SignUpView.swift
//  Vollmed
//
//  Created by Elisangela Pethke on 21.02.24.
//

import SwiftUI

struct SignUpView: View {
    
    let service = WebService()

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var cpf: String = ""
    @State private var phoneNumber: String = ""
    @State private var healthPlan: String
    @State private var password: String = "" // plano de saude
    @State private var showAlert : Bool = false
    @State private var isPatientRegistered: Bool = false
    @State private var navigateToSignIn: Bool = false



    let healthPlans: [String] = [
        "Amil","Unimed","Bradesco Saúde", "SulAmerica", "HapVida", "Notredame", "Intermedica", "São Francisco Saúde", "Golden Cross", "Medical Saúde", "America Saúde", "Outro"
        
    ]
    
    init() {
        self.healthPlan = healthPlans [0]
    }
    
    func register() async {
        let patient = Patient(id: nil, cpf: cpf, name: name, email: email, password: password, phoneNumber: phoneNumber, healthPlan: healthPlan)
        do{
        
            if (try await
                 // antes estava assim: if let patientRegistered = try await
                
                service.registerPatient(patient: patient)) != nil {
                isPatientRegistered = true
              
                
            } else {
                isPatientRegistered = false
            }
            
        } catch {
            isPatientRegistered = false
            print("We had an error trying to register a new patient \(error)")
            
            
        }
        showAlert = true
    }
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading) {
    
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center)
                    .padding(.vertical)
                
                Text("Welcome!")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.accent)
                
                Text("Create your account.")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                   
                Text("Name")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("Name", text: $name)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14)
                    .autocorrectionDisabled()
                    .overlay(
                    RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.accent, lineWidth: 1.2)
                                )
                Text("E-mail")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("E-mail", text: $email)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .overlay(
                    RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.accent, lineWidth: 1.2))
                   
                
                Text("Document")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                   
                    
                
                TextField("Document Number", text: $cpf)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14)
                    .autocorrectionDisabled()
                    .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.accent, lineWidth: 1.2))
                                
                Text("Phone Number")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("Phone Number", text: $phoneNumber)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14)
                    .autocorrectionDisabled()
                    .overlay(
                    RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.accent, lineWidth: 1.2))
                
                Text("Password")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                SecureField("Enter your password here", text: $password)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14)
                    .autocorrectionDisabled()
                    .overlay(
                    RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.accent, lineWidth: 1.2))
                
                HStack{
                    Text("Select your healthplan")
                        .font(.system(size: 16))
                        .bold()
                        .foregroundStyle(.accent)
                        .padding(.horizontal, 18)
                    
                    Picker("Select your plan", selection: $healthPlan) {
                        ForEach(healthPlans, id: \.self) { healthPlan in
                            Text(healthPlan)
                    }
                        
                    }
                    .pickerStyle(DefaultPickerStyle())
                }
                
            
                Button(action: {
                    Task {
                     await register()
                    }
                    
                }, label: {
                    ButtonView(text: "Register", buttonType: .primary)
                })
               
                HStack{
                    
                    Text("Do you have an account?")
                        .foregroundStyle(.accent)
                        .bold()
                        .padding(5)
                        
                    NavigationLink {
                        SignInView()
                    } label: {
                        Text("Sign in here")
                        .foregroundStyle(.blue)
                        
                    }

                }
            }
        }
        .navigationBarBackButtonHidden()
        .padding()
        .alert(isPatientRegistered ? "Sucess" : "We have an Error", isPresented: $showAlert, presenting: $isPatientRegistered) { _ in
            Button(action: {
                navigateToSignIn = true
            }, label: {
                Text("OK")
            })
        } message: { _ in
            if isPatientRegistered {
                Text("Patient has been successfully registered!")
            } else{
                Text("We had an error trying to register a new patient, please try again later.")
            }
        }

        .navigationDestination(isPresented: $navigateToSignIn) {
            SignInView()
        }
        

    }
}

#Preview {
    SignUpView()
}
