//
//  TweetService.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 03.08.23.
//

import Firebase

struct TweetService {
  
  func uploadTweet(caption: String, completion: @escaping (Bool) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    let data: [String: Any] = ["uid": uid,
                               "caption": caption,
                               "likes": 0,
                               "timestamp": Timestamp(date: Date())]
    
    Firestore.firestore().collection("tweets").document()
      .setData(data) { error in
        if let error = error {
          print(error.localizedDescription)
          completion(false)
        }
        
        completion(true)
      }
  }
  
  func reTweet(caption: String, completion: @escaping (Bool) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    let data: [String: Any] = ["reuid": uid,
                               "recaption": caption,
                               "likes": 0,
                               "timestamp": Timestamp(date: Date()),
                               "uid": uid,
                               "caption": caption,
                               "likes": 0,
                               "timestamp": Timestamp(date: Date())]
    
    Firestore.firestore().collection("tweets").document()
      .setData(data) { error in
        if let error = error {
          print(error.localizedDescription)
          completion(false)
        }
        
        completion(true)
      }
  }
  
  func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
    Firestore.firestore().collection("tweets")
      .order(by: "timestamp", descending: false)
      .getDocuments { snapshot, _ in
      guard let documents = snapshot?.documents else { return }
      let tweets = documents.compactMap({ try? $0.data(as: Tweet.self) })
      completion(tweets)
    }
  }
  
  func fetchTweets(foruid uid: String, completion: @escaping ([Tweet]) -> Void) {
    Firestore.firestore().collection("tweets")
      .whereField("uid", isEqualTo: uid)
      .getDocuments { snapshot, _ in
      guard let documents = snapshot?.documents else { return }
      let tweets = documents.compactMap({ try? $0.data(as: Tweet.self) })
      completion(tweets.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() } ))
    }
  }
}

// MARK: - Likes
extension TweetService {
  func likeTweet(_ tweet: Tweet, completion: @escaping () -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let tweetId = tweet.id else { return }
    
    let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
    
    Firestore.firestore().collection("tweets").document(tweetId)
      .updateData(["likes": tweet.likes + 1]) { _ in
        userLikesRef.document(tweetId).setData([:]) { _ in
          completion()
        }
      }
  }
  
  func unLikeTweet(_ tweet: Tweet, completion: @escaping () -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let tweetId = tweet.id else { return }
    guard tweet.likes > 0 else { return }
    
    let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
    
    Firestore.firestore().collection("tweets").document(tweetId)
      .updateData(["likes": tweet.likes - 1]) { _ in
        userLikesRef.document(tweetId).delete { _ in
          completion()
        }
      }
  }
  
  func checkIfUserLikedTweet(_ tweet: Tweet, comletion: @escaping (Bool) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    guard let tweetId = tweet.id else { return }
    
    Firestore.firestore().collection("users")
      .document(uid)
      .collection("user-likes")
      .document(tweetId).getDocument { snapshot, _ in
        guard let snapshot = snapshot else { return }
        comletion(snapshot.exists)
      }
  }
  
  func fetchLikedTweets(foruid uid: String, completion: @escaping ([Tweet]) -> Void) {
    var tweets: [Tweet] = []
    
    Firestore.firestore().collection("users")
      .document(uid)
      .collection("user-likes")
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
