//
//  Tweet.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 04.08.23.
//

import FirebaseFirestoreSwift
import Firebase

struct Tweet: Identifiable, Decodable {
  @DocumentID var id: String?
  
  let caption: String
  let timestamp: Timestamp
  let uid: String
  let likes: Int
  
  var user: User?
  var didLike: Bool? = false
  var marked: Bool? = false
}
