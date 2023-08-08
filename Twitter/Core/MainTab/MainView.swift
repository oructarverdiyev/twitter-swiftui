//
//  MainView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 12.07.23.
//

import SwiftUI
import Kingfisher

struct MainView: View {
  @State private var showMenu = false
  @State var offset: CGFloat = 0
  @State var lastStoredOffset: CGFloat = 0
  @State private var selectedIndex = 0
  
  @EnvironmentObject var viewModel: AuthViewModel
  
    var body: some View {
      
      NavigationStack {
        Group {
          if viewModel.userSession == nil {
            LoginView()
          } else {
            mainView()
          }
        }
      }
    }
}

extension MainView {
  private func mainView() -> some View {
    let sideBarWidth = getRect().width - 90
    
    return ZStack(alignment: .topLeading) {
      
      HStack(spacing: 0) {
        SideMenuView()
        
        MainTabView(selectedIndex: $selectedIndex)
          .navigationBarHidden(showMenu)
          .frame(width: getRect().width)
        
          .overlay(
            Rectangle()
              .fill(
              Color.primary.opacity(Double((offset / sideBarWidth) / 5))
            )
              .ignoresSafeArea(.container, edges: .vertical)
              .onTapGesture {
                withAnimation {
                  showMenu.toggle()
                }
              }
          )
      }
      
      
    }
    .frame(width: getRect().width + sideBarWidth)
    .offset(x: -sideBarWidth / 2)
    .offset(x: offset)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        if let user = viewModel.currentUser {
          Button {
            showMenu.toggle()
          } label: {
            KFImage(URL(string: user.profileImageUrl))
              .resizable()
              .scaledToFill()
              .clipShape(Circle())
              .frame(width: 32, height: 32)
          }
        }
      }
    }
    .animation(.easeOut, value: offset == 0)
    .onChange(of: showMenu) { newValue in
      if showMenu && offset == 0 {
        offset = sideBarWidth
        lastStoredOffset = offset
      }
      
      if !showMenu && offset == sideBarWidth {
        offset = 0
        lastStoredOffset = 0
      }
    }
    .onAppear{
      showMenu = false
    }
    .navigationTitle(navigationTitle)
    .navigationBarTitleDisplayMode(.inline)
    .safeAreaInset(edge: .top) {
      if showMenu == false {
        Color.clear
          .frame(height: 0)
          .background(.bar)
          .border(.black)
      }
    }
  }
}

extension MainView {
  private var navigationTitle: String {
    switch selectedIndex {
    case 0: return "Home"
    case 1: return "Explore"
    case 2: return "Notifications"
    case 3: return "Messages"
    default: return ""
    }
  }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        MainView()
      }
    }
}
