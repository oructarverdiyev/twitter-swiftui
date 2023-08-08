//
//  BookmarkService.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 08.08.23.
//

import Firebase

struct BookmarkService {
  
  func addBookmark(_ tweet: Tweet, completion: @escaping () -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let tweetId = tweet.id else { return }
    
    let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-bookmarks")
    
    userLikesRef.document(tweetId).setData([:]) { _ in
      completion()
    }
  }
  
  func removeBookmark(_ tweet: Tweet, completion: @escaping () -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let tweetId = tweet.id else { return }
    
    let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-bookmarks")
    userLikesRef.document(tweetId).delete { _ in
      completion()
    }
  }
  
  func checkIfUserBookmark(_ tweet: Tweet, comletion: @escaping (Bool) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let tweetId = tweet.id else { return }
    
    Firestore.firestore().collection("users")
      .document(uid)
      .collection("user-bookmarks")
      .document(tweetId).getDocument { snapshot, _ in
        guard let snapshot = snapshot else { return }
        comletion(snapshot.exists)
      }
  }
  
  func fetchBookmarks(foruid uid: String, completion: @escaping ([Tweet]) -> Void) {
    var tweets: [Tweet] = []
    
    Firestore.firestore().collection("users")
      .document(uid)
      .collection("user-bookmarks")
      .getDocuments { snapshot, _ in
        guard let documents = snapshot?.documents else { return }
        
        documents.forEach { doc in
          let tweetId = doc.documentID
          
          Firestore.firestore().collection("tweets")
            .document(tweetId)
            .getDocument { snapshot, _ in
              guard let tweet = try? snapshot?.data(as: Tweet.self) else { return }
              tweets.append(tweet)
              
              completion(tweets)
            }
        }
      }
  }
  
}
