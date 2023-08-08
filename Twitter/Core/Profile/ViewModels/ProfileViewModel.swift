//
//  ProfileViewModel.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 04.08.23.
//

import Foundation

class ProfileViewModel: ObservableObject {
  @Published var tweets: [Tweet] = []
  @Published var likedTweets: [Tweet] = []
  
  private let service = TweetService()
  private let userService = UserService()
  let user: User
  
  init(user: User) {
    self.user = user
    self.fetchUserTweets()
    self.fetchLikedTweets()
  }
  
  var actionButtonTitle: String {
    return user.isCurrentUser ? "Edit profile" : "Follow"
  }
  
  func tweets(forFilter filter: TweetFilterViewModel) -> [Tweet] {
    switch filter {
    case .tweets:
      return tweets
    case .replies:
      return []
    case .likes:
      return likedTweets
    }
  }
  
  func fetchUserTweets() {
    guard let uid = user.id else { return }
    service.fetchTweets(foruid: uid) { [weak self] tweets in
      self?.tweets = tweets
      
      for i in 0 ..< tweets.count {
        self?.tweets[i].user = self?.user
      }
    }
  }
  
  func fetchLikedTweets() {
    guard let uid = user.id else { return }
    service.fetchLikedTweets(foruid: uid) { [weak self] tweets in
      self?.likedTweets = tweets
      
      for i in 0 ..< tweets.count {
        let uid = tweets[i].uid
        self?.userService.fetchUser(withuid: uid, completion: { [weak self] user in
          self?.likedTweets[i].user = user
        })
      }
    }
  }
}
