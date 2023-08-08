//
//  NotificationsView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 12.07.23.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        Text("Notifications View")
      
        .tabItem {
          Image(systemName: "bell")
        }
        .tag(TabIndex.notification)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
