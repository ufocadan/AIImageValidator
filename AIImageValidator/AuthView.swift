//
//  AuthView.swift
//  AIImageValidator
//
//  Created by Ünal Foçadan on 2.07.2024.
//

import SwiftUI

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoginMode = true
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            Picker(selection: $isLoginMode, label: Text("Picker here")) {
                Text("Login")
                    .tag(true)
                Text("Sign Up")
                    .tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))

            Button(action: {
                if isLoginMode {
                    authViewModel.signIn(email: email, password: password)
                } else {
                    authViewModel.signUp(email: email, password: password)
                }
            }) {
                Text(isLoginMode ? "Login" : "Sign Up")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
        .padding()
    }
}
