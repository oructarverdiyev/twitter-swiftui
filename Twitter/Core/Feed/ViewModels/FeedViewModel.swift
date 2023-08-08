//
//  FeedViewModel.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 04.08.23.
//

import Foundation

class FeedViewModel: ObservableObject {
  
  let service = TweetService()
  let userService = UserService()
  @Published var tweets: [Tweet] = []
  
  init() {
    fetchTweets()
  }
  
  func fetchTweets() {
    service.fetchTweets { [weak self] tweets in
      self?.tweets = tweets
      
      for i in 0 ..< tweets.count {
        let uid = tweets[i].uid
        self?.userService.fetchUser(withuid: uid, completion: { [weak self] user in
          self?.tweets[i].user = user
        })
      }
    }
  }
}
