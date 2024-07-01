//
//  ContentView.swift
//  AIImageValidator
//
//  Created by Ünal Foçadan on 1.07.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        if authViewModel.isSignedIn {
            MainView() // Your main view after login
        } else {
            AuthView()
        }
    }
}

struct MainView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            Text("Welcome!")
            Button("Sign Out") {
                authViewModel.signOut()
            }
        }
    }
}
