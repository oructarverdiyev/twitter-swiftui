//
//  ProgressView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 01.08.23.
//

import SwiftUI

struct CProgressView: View {
    var body: some View {
      VStack {
        ProgressView("Loading...")
          .controlSize(.large)
          .tint(.white)
          .foregroundColor(.white)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color(.systemBlue))
      .ignoresSafeArea()
    }
}

struct CProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CProgressView()
    }
}
