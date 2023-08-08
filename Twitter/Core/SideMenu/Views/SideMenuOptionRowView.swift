//
//  SideMenuOptionRowView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 14.07.23.
//

import SwiftUI

struct SideMenuOptionRowView: View {
  
  let viewModel: SideMenuViewModel
  
    var body: some View {
      HStack(spacing: 16) {
        Image(systemName: viewModel.imageName)
          .font(.headline)
          .foregroundColor(.gray)
        
        Text(viewModel.description)
          .font(.subheadline)
          .foregroundColor(.black)
        
        Spacer()
      }
      .frame(height: 40)
      .padding(.horizontal)
    }
}

struct SideMenuOptionRowView_Previews: PreviewProvider {
    static var previews: some View {
      SideMenuOptionRowView(viewModel: .profile)
    }
}
