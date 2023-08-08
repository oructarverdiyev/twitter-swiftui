//
//  MainTabView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 12.07.23.
//

import SwiftUI

struct MainTabView: View {
  
  @Binding var selectedIndex: Int
  
  init(selectedIndex: Binding<Int>) {
    self._selectedIndex = selectedIndex
  }
  
    var body: some View {
      TabView(selection: $selectedIndex) {
        FeedView()
        
        ExploreView()
        
        NotificationsView()
        
        MessagesView()
      }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
      MainTabView(selectedIndex: .constant(0))
    }
}
