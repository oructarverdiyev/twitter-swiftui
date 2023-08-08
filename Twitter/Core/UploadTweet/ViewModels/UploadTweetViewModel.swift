//
//  UploadTweetViewModel.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 03.08.23.
//

import Foundation

class UploadTweetViewModel: ObservableObject {
  
  @Published var didUploadTweet = false
  
  let service = TweetService()
  
  func uploadTweet(withCaption caption: String) {
    service.uploadTweet(caption: caption) { success in
      if success {
        self.didUploadTweet = true
      } else {
        
      }
    }
  }
  
  func fetchTweets() {
    
  }
}
