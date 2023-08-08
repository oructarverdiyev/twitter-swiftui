//
//  UserRowView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 13.07.23.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
  
  let user: User
  
  var body: some View {
    HStack(spacing: 12) {
      KFImage(URL(string: user.profileImageUrl))
        .resizable()
        .scaledToFill()
        .clipShape(Circle())
        .frame(width: 56, height: 56)
      
      VStack(alignment: .leading, spacing: 4) {
        Text(user.username)
          .font(.subheadline)
          .bold()
        
        Text(user.fullname)
          .font(.subheadline)
          .foregroundColor(.gray)
      }
      
      Spacer()
    }
    .padding(.horizontal)
    .padding(.vertical, 4)
  }
}

//struct UserRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserRowView()
//    }
//}
