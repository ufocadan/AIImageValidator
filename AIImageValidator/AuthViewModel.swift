//
//  AuthViewModel.swift
//  AIImageValidator
//
//  Created by Ünal Foçadan on 2.07.2024.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isSignedIn = false

    var auth: Auth {
        return Auth.auth()
    }

    var isSignedInPublished: Bool {
        return auth.currentUser != nil
    }

    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }

            DispatchQueue.main.async {
                self?.isSignedIn = true
            }
        }
    }

    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }

            DispatchQueue.main.async {
                self?.isSignedIn = true
            }
        }
    }

    func signOut() {
        try? auth.signOut()
        self.isSignedIn = false
    }
}

