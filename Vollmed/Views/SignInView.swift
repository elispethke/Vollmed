//
//  SignInView.swift
//  Vollmed
//
//  Created by Elisangela Pethke on 21.02.24.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert : Bool = false
    
    let service = WebService()
    
    func login() async {
       
        do {
            if let response = try await service.loginPatient(email: email, password: password) {
                KeychainHelper.save(value: response.token, key: "app-vollmed-token")
                KeychainHelper.save(value: response.id, key: "app-vollmed-patient-id")
            } else {
                showAlert = true
            }
        } catch {
            showAlert = true
            print("Ocorreu um erro no login: \(error)")
        }
    }


    var body: some View {
        
        VStack(alignment: .leading, spacing: 16.0){
            Image(.logo)
                .resizable()
                .scaledToFit()
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 66.0)
            
            Text("Hello!")
                .foregroundStyle(.accent)
                .bold()
                .font(.title)
                .padding(5)
                
                
            
            Text("Fill in to Log In.")
                .foregroundStyle(.gray)
                .bold()
                .font(.title3)
                .padding(5)
                
            
            Text("E-mail")
                .foregroundStyle(.accent)
                .bold()
                .font(.title3)
                .padding(5)
            
            TextField("E-mail", text: $email)
                .padding(14)
                .background(Color(.gray).opacity(0.20))
                .cornerRadius(16)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .padding(5)
            
            Text("Password")
                .foregroundStyle(.accent)
                .bold()
                .font(.title3)
                .padding(5)
            
            SecureField("Password", text: $password)
                .padding(14)
                .background(Color(.gray).opacity(0.20))
                .cornerRadius(16)
                .padding(5)
            
            Button(action: {
                Task {
                    await login()
                }
            }, label: {
                ButtonView(text: "Enter")
                
            })
            .padding(5)
            
            HStack{
                Text("if you dont's have an account")
                    .padding(12)
                    .foregroundStyle(.accent)
                    .bold()
                
                NavigationLink {
                    
                    SignUpView()
                    
                } label: {
                    Text("Sign up here!")
                        .bold()
                        .foregroundStyle(.blue)
                        
                }
            }
        }
        .navigationBarBackButtonHidden()
        .padding(.bottom)
        .alert("OPS, Algo deu errado", isPresented: $showAlert) {
            Button {}
                
             label: {
                Text("OK")
            }

        } message: {
            Text("Houve um erro ate tentar entrar em sua conta, por favor tentar mais tarde!")
        }

    }
}

#Preview {
    SignInView()
}
