//
//  BookmarksViewModel.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 08.08.23.
//

import Foundation

class BookmarksViewModel: ObservableObject {
  
  @Published var tweets: [Tweet] = []
  
  private let bookmarkService = BookmarkService()
  private let userService = UserService()
  
  let user: User
  
  init(user: User) {
    self.user = user
  }
  
  func fetchBookmarks() {
    guard let uid = user.id else { return }
    bookmarkService.fetchBookmarks(foruid: uid) { [weak self] tweets in
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
