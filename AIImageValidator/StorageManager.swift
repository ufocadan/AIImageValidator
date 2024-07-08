//
//  StorageManager.swift
//  AIImageValidator
//
//  Created by Ünal Foçadan on 8.07.2024.
//

import Foundation
import FirebaseStorage

class StorageManager {
    let storage = Storage.storage()

    func uploadImage(_ image: UIImage, completion: @escaping (URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(nil)
            return
        }

        let storageRef = storage.reference().child("images/\(UUID().uuidString).jpg")
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Failed to upload image: \(error.localizedDescription)")
                completion(nil)
                return
            }

            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Failed to retrieve download URL: \(error.localizedDescription)")
                    completion(nil)
                    return
                }

                completion(url)
            }
        }
    }
}
