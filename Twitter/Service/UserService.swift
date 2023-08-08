//
//  UserService.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 01.08.23.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
  
  func fetchUser(withuid uid: String, completion: @escaping(User) -> Void) {
    Firestore.firestore().collection("users")
      .document(uid)
      .getDocument { snapsot, error in
        
        guard let snapsot = snapsot else { return }
        guard let user = try? snapsot.data(as: User.self) else { return }
        completion(user)
      }
  }
  
  func fetchAllUsers(completion: @escaping([User]) -> Void) {
    Firestore.firestore().collection("users")
      .getDocuments { snapshot, _ in
        guard let documents = snapshot?.documents else { return }
        let users = documents.compactMap({ try? $0.data(as: User.self) })
        completion(users)
      }
  }
}
