//
//  ImageUploader.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 01.08.23.
//

import FirebaseStorage
import UIKit

struct ImageUploader {
  
  static func uploadImage(image: UIImage, completion: @escaping (String) -> Void) {
    guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
    
    let fileName = NSUUID().uuidString
    let ref = Storage.storage().reference(withPath: "/profile_image/\(fileName)")
    
    ref.putData(imageData) { _, error in
      if let error = error {
        print("DEBUG: Failed to upload image \(error.localizedDescription)")
        return
      }
      
      ref.downloadURL { imageUrl, _ in
        guard let imageUrl = imageUrl?.absoluteString else { return }
        completion(imageUrl)
      }
    }
  }
}
