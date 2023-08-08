//
//  MessagesView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 12.07.23.
//

import SwiftUI

struct MessagesView: View {
    var body: some View {
        Text("Messages View")
      
        .tabItem {
          Image(systemName: "envelope")
        }
        .tag(TabIndex.messages)
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
