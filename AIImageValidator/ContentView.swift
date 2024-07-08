//
//  ContentView.swift
//  AIImageValidator
//
//  Created by Ünal Foçadan on 1.07.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var image: UIImage?
    @State private var showImagePicker = false
    @State private var uploadURL: URL?

    var body: some View {
        if authViewModel.isSignedIn {
            VStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }

                Button("Select Image") {
                    showImagePicker = true
                }
                .padding()

                if image != nil {
                    Button("Upload Image") {
                        uploadImage()
                    }
                    .padding()
                }

                if let uploadURL = uploadURL {
                    Text("Image uploaded to: \(uploadURL.absoluteString)")
                        .padding()
                }

                Button("Sign Out") {
                    authViewModel.signOut()
                }
                .padding()
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image)
            }
            .padding()
        } else {
            AuthView()
        }
    }

    func uploadImage() {
        guard let image = image else { return }
        StorageManager().uploadImage(image) { url in
            if let url = url {
                self.uploadURL = url
            }
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
