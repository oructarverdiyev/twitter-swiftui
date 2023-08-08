//
//  ExploreView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 12.07.23.
//

import SwiftUI

struct ExploreView: View {
  
  @ObservedObject var viewModel = ExploreViewModel()
  
  var body: some View {
    VStack {
      SearchBar(text: $viewModel.searchText)
        .padding()
      
      ScrollView {
        LazyVStack {
          ForEach(viewModel.searchableUsers) { user in
            NavigationLink {
              ProfileView(user)
            } label: {
              UserRowView(user: user)
            }
          }
        }
      }
    }
    .navigationTitle("Explore")
    .navigationBarTitleDisplayMode(.inline)
    
    .tabItem {
      Image(systemName: "magnifyingglass")
    }
    .tag(TabIndex.search)
  }
}

struct ExploreView_Previews: PreviewProvider {
  static var previews: some View {
    ExploreView()
  }
}
