//
//  TweetRowViewModel.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 04.08.23.
//

import Foundation

class TweetRowViewModel: ObservableObject {
  
  private let service = TweetService()
  private let bookmarkService = BookmarkService()
  
  @Published var tweet: Tweet
  
  init(tweet: Tweet) {
    self.tweet = tweet
    checkIfUserLikedTweet()
    checkIfUserBookmark()
  }
  
  func likeTweet() {
    service.likeTweet(tweet) {
      self.tweet.didLike = true
    }
  }
  
  func unlikeTweet() {
    service.unLikeTweet(tweet) {
      self.tweet.didLike = false
    }
  }
  
  func checkIfUserLikedTweet() {
    service.checkIfUserLikedTweet(tweet) { didLike in
      if didLike {
        self.tweet.didLike = true
      }
    }
  }
  
  func addBookmark() {
    bookmarkService.addBookmark(tweet) {
      self.tweet.marked = true
    }
  }
  
  func removeBookmark() {
    bookmarkService.removeBookmark(tweet) {
      self.tweet.marked = false
    }
  }
  
  func checkIfUserBookmark() {
    bookmarkService.checkIfUserBookmark(tweet) { marked in
      if marked {
        self.tweet.marked = true
      }
    }
  }
}
