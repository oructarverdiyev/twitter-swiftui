//
//  ProfileView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 12.07.23.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
  
  @State private var selectionFilter: TweetFilterViewModel = .tweets
  @ObservedObject var viewModel: ProfileViewModel
  @Environment(\.presentationMode) var mode
  @Namespace var animation
  
  init(_ user: User) {
    self.viewModel = ProfileViewModel(user: user)
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      headerView()
      
      actionButtons()
      
      userInfoDetails()
      
      tweetFilterBar()
      
      tweetsView()
      
      Spacer()
    }
    .navigationBarBackButtonHidden()
  }
}

extension ProfileView {
  private func headerView() -> some View {
    ZStack(alignment: .bottomLeading) {
      Color(.systemBlue)
        .ignoresSafeArea()
      
      VStack {
        Button {
          mode.wrappedValue.dismiss()
        } label: {
          Image(systemName: "arrow.left")
            .resizable()
            .frame(width: 20, height: 16)
            .foregroundColor(.white)
            .padding(.bottom, 40)
        }
        
        KFImage(URL(string: viewModel.user.profileImageUrl))
          .resizable()
          .scaledToFill()
          .clipShape(Circle())
          .frame(width: 72, height: 72)
          .padding(.bottom, -36)
          .padding(.leading, 16)
      }
    }
    .frame(height: 96)
  }
  
  private func actionButtons() -> some View {
    HStack(spacing: 12) {
      Spacer()
      
      Image(systemName: "bell.badge")
        .font(.title3)
        .padding(6)
        .overlay(Circle().stroke(Color.gray, lineWidth: 0.75))
      
      Button {
        
      } label: {
        Text(viewModel.actionButtonTitle)
          .font(.subheadline).bold()
          .frame(width: 120, height: 32)
          .foregroundColor(.black)
          .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 0.75))
      }
    }
    .padding(.trailing)
  }
  
  private func userInfoDetails() -> some View {
    VStack(alignment: .leading, spacing: 4) {
      HStack {
        Text(viewModel.user.fullname)
          .font(.title2)
          .bold()
        
        Image(systemName: "checkmark.seal.fill")
          .foregroundColor(Color(.systemBlue))
      }
      
      Text("@\(viewModel.user.username)")
        .font(.subheadline)
        .foregroundColor(.gray)
      
      Text("")
        .font(.subheadline)
        .padding(.vertical)
      
      HStack(spacing: 24) {
        HStack {
          Image(systemName: "mappin.and.ellipse")
          
          Text("Azerbaijan, Baku")
        }
        
        HStack {
          Image(systemName: "link")
          
          Text("oructarverdiyev.com")
        }
      }
      .font(.caption)
      .foregroundColor(.gray)
      
      UserStatsView()
        .padding(.vertical)
    }
    .padding(.horizontal)
  }
  
  private func tweetFilterBar() -> some View {
    HStack {
      ForEach(TweetFilterViewModel.allCases, id: \.rawValue) { item in
        VStack {
          Text(item.title)
            .font(.subheadline)
            .fontWeight(selectionFilter == item ? .semibold : .regular)
            .foregroundColor(selectionFilter == item ? .black : .gray)
          
          if selectionFilter == item {
            Capsule()
              .foregroundColor(Color(.systemBlue))
              .frame(height: 3)
              .matchedGeometryEffect(id: "filter", in: animation)
          } else {
            Capsule()
              .foregroundColor(Color(.clear))
              .frame(height: 3)
          }
        }
        .onTapGesture {
          withAnimation(.easeInOut) {
            self.selectionFilter = item
          }
        }
      }
    }
    .overlay(
      Divider()
        .offset(x: 0, y: 16)
    )
  }
  
  private func tweetsView() -> some View {
    ScrollView {
      LazyVStack {
        ForEach(viewModel.tweets(forFilter: self.selectionFilter)) { tweet in
          TweetRowView(tweet: tweet)
        }
      }
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
      ProfileView(User(username: "oructarverdiyev",
                       fullname: "Oruc Tarverdiyev",
                       profileImageUrl: "",
                       email: "oructarverdiyev@yandex.com"))
    }
}
