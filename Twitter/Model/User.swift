//
//  User.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 01.08.23.
//

import Firebase
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
  @DocumentID var id: String?
  let username: String
  let fullname: String
  let profileImageUrl: String
  let email: String
  
  var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == id}
}
