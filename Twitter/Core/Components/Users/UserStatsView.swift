//
//  UserStatsView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 13.07.23.
//

import SwiftUI

struct UserStatsView: View {
  var body: some View {
    HStack(spacing: 24) {
      HStack(spacing: 4) {
        Text("205")
          .font(.subheadline)
          .bold()
        
        Text("Following")
          .font(.caption)
          .foregroundColor(.gray)
      }
      
      HStack(spacing: 4) {
        Text("1.2M")
          .font(.subheadline)
          .bold()
        
        Text("Followers")
          .font(.caption)
          .foregroundColor(.gray)
      }
    }
  }
}

struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView()
    }
}