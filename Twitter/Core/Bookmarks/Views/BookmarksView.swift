//
//  BookmarksView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 08.08.23.
//

import SwiftUI

struct BookmarksView: View {
  
  @ObservedObject var viewModel: BookmarksViewModel
  
  init(_ user: User) {
    self.viewModel = BookmarksViewModel(user: user)
  }
  
  var body: some View {
    VStack {
      bookmarkList()
    }
    .navigationTitle("Bookmarks")
    .task {
      viewModel.fetchBookmarks()
    }
  }
  
  private func bookmarkList() -> some View {
    ScrollView {
      LazyVStack {
        ForEach(viewModel.tweets) { tweet in
          TweetRowView(tweet: tweet)
        }
      }
    }
  }
}

//struct BookmarksView_Previews: PreviewProvider {
//  static var previews: some View {
//    BookmarksView()
//  }
//}
