//
//  TweetFilterViewModel.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 13.07.23.
//

import Foundation

enum TweetFilterViewModel: Int, CaseIterable {
case tweets
case replies
case likes
  
  var title: String {
    switch self {
    case .tweets:
      return "Tweets"
    case .replies:
      return "Replies"
    case .likes:
      return "Likes"
    }
  }
}
