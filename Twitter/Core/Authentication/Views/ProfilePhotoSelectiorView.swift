//
//  ProfilePhotoSelectiorView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 01.08.23.
//

import SwiftUI

struct ProfilePhotoSelectiorView: View {
  
  @EnvironmentObject var viewModel: AuthViewModel
  
  @State private var showProgressView = false
  @State private var showImagePicker = false
  @State private var selectedImage: UIImage?
  @State private var profileImage: Image?
  
  @Environment(\.presentationMode) var presentationMode
  
    var body: some View {
      VStack {
        AuthHeaderView(title1: "Setup account",
                       title2: "Add a profile photo")
        
        Button {
          showImagePicker.toggle()
        } label: {
          if let profileImage = profileImage {
            profileImage
              .resizable()
              .modifier(ProfileImageModifier())
          } else {
            Image("plus_photo")
              .resizable()
              .modifier(ProfileImageModifier())
          }
        }
        .sheet(isPresented: $showImagePicker,
               onDismiss: loadImage) {
          ImagePicker(selectedImage: $selectedImage)
        }
        .padding(.top, 44)
        
        if let selectedImage = selectedImage {
          countinueButton(selectedImage)
        }
        
        Spacer()
      }
      .ignoresSafeArea()
      .overlay {
        if showProgressView {
          CProgressView()
        }
      }
    }
  
  func loadImage() {
    guard let selectedImage = selectedImage else { return }
    profileImage = Image(uiImage: selectedImage)
  }
}

extension ProfilePhotoSelectiorView {
  private func countinueButton(_ image: UIImage) -> some View {
    Button {
      showProgressView = true
      viewModel.uploadProfileImage(image) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
          presentationMode.wrappedValue.dismiss()
          showProgressView = false
        }
      }
    } label: {
      Text("Continue")
        .font(.headline)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(Color(.systemBlue))
        .clipShape(Capsule())
        .padding()
    }
  }
}

private struct ProfileImageModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(Color(.systemBlue))
      .scaledToFill()
      .frame(width: 180, height: 180)
      .clipShape(Circle())
  }
}

struct ProfilePhotoSelectiorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectiorView()
    }
}
