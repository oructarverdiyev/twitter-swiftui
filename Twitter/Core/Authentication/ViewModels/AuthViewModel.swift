//
//  AuthViewModel.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 27.07.23.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject {
  
  @Published var userSession: FirebaseAuth.User?
  @Published var didAuthenticateUser = false
  @Published var currentUser: User?
  private var tempUserSession: FirebaseAuth.User?
  private let service = UserService()
  
  init() {
    self.userSession = Auth.auth().currentUser
    self.fetchUser()
  }
  
  func login(withemail email: String, password: String) {
    Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
      if let error = error {
        print("DEBUG: Failed to sign in with error: \(error.localizedDescription)")
        return
      }
      
      guard let user = result?.user else { return }
      self?.userSession = user
      self?.fetchUser()
    }
  }
  
  func register(withemail email: String, password: String, fullname: String, username: String) {
    Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
      if let error = error {
        print("DEBUG: Failed to register with error: \(error.localizedDescription)")
        return
      }
      
      guard let user = result?.user else { return }
      self?.tempUserSession = user
      
      let data = ["email": email,
                  "username": username.lowercased(),
                  "fullname": fullname,
                  "uid": user.uid]
      
      Firestore.firestore().collection("users")
        .document(user.uid)
        .setData(data) { [weak self] _ in
          self?.didAuthenticateUser = true
        }
    }
  }
  
  func signOut() {
    userSession = nil
    try? Auth.auth().signOut()
  }
  
  func uploadProfileImage(_ image: UIImage, completion: @escaping () -> ()) {
    guard let uid = tempUserSession?.uid else { return }
    
    ImageUploader.uploadImage(image: image) { profileImageUrl in
      Firestore.firestore().collection("users")
        .document(uid)
        .updateData(["profileImageUrl": profileImageUrl]) {[weak self] _ in
          self?.userSession = self?.tempUserSession
          self?.fetchUser()
          completion()
        }
    }
  }
  
  func fetchUser() {
    guard let uid = self.userSession?.uid else { return }
    service.fetchUser(withuid: uid) { [weak self] user in
      self?.currentUser = user
    }
  }
}

