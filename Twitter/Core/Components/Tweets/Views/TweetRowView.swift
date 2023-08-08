//
//  TweetRowView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 12.07.23.
//

import SwiftUI
import Kingfisher

struct TweetRowView: View {
  
  @ObservedObject var viewModel: TweetRowViewModel
  
  init(tweet: Tweet) {
    self.viewModel = TweetRowViewModel(tweet: tweet)
  }
  
    var body: some View {
      VStack(alignment: .leading) {
        
        if let user = viewModel.tweet.user {
          tweetDetail(user: user)
        }
        
        actionButtons()
        
        Divider()
      }
      .padding()
    }
}

extension TweetRowView {
  
  private func tweetDetail(user: User) -> some View {
    HStack(alignment: .top, spacing: 12) {
      KFImage(URL(string: user.profileImageUrl))
        .resizable()
        .scaledToFill()
        .frame(width: 56, height: 56)
        .clipShape(Circle())
      
      VStack(alignment: .leading, spacing: 4) {
        
        HStack {
          Text(user.fullname)
            .font(.subheadline).bold()
          
          Text("@\(user.username)")
            .foregroundColor(.gray)
            .font(.caption)
          
          Text("2w")
            .foregroundColor(.gray)
            .font(.caption)
        }
        
        Text(viewModel.tweet.caption)
          .font(.subheadline)
          .multilineTextAlignment(.leading)
      }
    }
  }
  
  private func actionButtons() -> some View {
    HStack {
      
      Button {
        
      } label: {
        Image(systemName: "bubble.left")
          .font(.subheadline)
      }
      
      Spacer()
      
      Button {
        
      } label: {
        Image(systemName: "arrow.2.squarepath")
          .font(.subheadline)
      }
      
      Spacer()

      Button {
        viewModel.tweet.didLike ?? false ?
        viewModel.unlikeTweet() :
        viewModel.likeTweet()
      } label: {
        Image(systemName: viewModel.tweet.didLike ?? false ? "heart.fill" : "heart")
          .foregroundColor(viewModel.tweet.didLike ?? false ? .red : .gray)
          .font(.subheadline)
      }
      
      Spacer()

      Button {
        viewModel.tweet.marked ?? false ?
        viewModel.removeBookmark() :
        viewModel.addBookmark()
      } label: {
        Image(systemName: viewModel.tweet.marked ?? false ? "bookmark.fill" : "bookmark")
          .foregroundColor(viewModel.tweet.marked ?? false ? .blue : .gray)
          .font(.subheadline)
      }
    }
    .padding()
    .foregroundColor(.gray)
  }
}

//struct TweetRowView_Previews: PreviewProvider {
//    static var previews: some View {
//      TweetRowView(tweet: <#Tweet#>)
//    }
//}
