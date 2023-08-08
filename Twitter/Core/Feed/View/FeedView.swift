//
//  FeedView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 12.07.23.
//

import SwiftUI

struct FeedView: View {
  
  @State private var showNewTweetView = false
  @ObservedObject var viewModel = FeedViewModel()
  
  var body: some View {
    
    ZStack(alignment: .bottomTrailing) {
      ScrollView {
        LazyVStack {
          ForEach(viewModel.tweets) { tweet in
            TweetRowView(tweet: tweet)
          }
        }
      }
      
      Button {
        showNewTweetView.toggle()
      } label: {
        Image("tweet_Post_Write")
          .resizable()
          .frame(width: 28, height: 28)
          .padding()
      }
      .background(Color(.systemBlue))
      .foregroundColor(.white) 
      .clipShape(Circle())
      .padding()
      .navigationBarTitleDisplayMode(.inline)
      .fullScreenCover(isPresented: $showNewTweetView) {
        NewTweetView()
      }
    }
    .tabItem {
      Image(systemName: "house")
    }
    .tag(TabIndex.home)
  }
}

struct FeedView_Previews: PreviewProvider {
  static var previews: some View {
    FeedView()
  }
}
