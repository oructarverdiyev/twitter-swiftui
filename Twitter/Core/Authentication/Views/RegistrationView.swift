//
//  RegistrationView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 27.07.23.
//

import SwiftUI

struct RegistrationView: View {
  @State private var email = ""
  @State private var username = ""
  @State private var fullname = ""
  @State private var password = ""
  
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var viewModel: AuthViewModel
  
    var body: some View {
      NavigationStack {
        VStack {
          headerView()
          
          textFields()
          
          signInButton()
          
          Spacer()
          
          loginButton()
        }
        .ignoresSafeArea()
        .navigationDestination(isPresented: $viewModel.didAuthenticateUser) {
          ProfilePhotoSelectiorView()
        }
      }
    }
}

extension RegistrationView {
  private func headerView() -> some View {
    AuthHeaderView(title1: "Get started.",
                   title2: "Create your account")
  }
  
  private func textFields() -> some View {
    VStack(spacing: 40) {
      CTextField(imageName: "envelope",
                 placeholderText: "Email",
                 text: $email)
      
      CTextField(imageName: "person",
                 placeholderText: "Username",
                 text: $username)
      
      CTextField(imageName: "person",
                 placeholderText: "Full name",
                 text: $fullname)
      
      CTextField(imageName: "lock",
                 placeholderText: "Password",
                 isSecureField: true,
                 text: $password)
    }
    .padding(32)
  }
  
  private func signInButton() -> some View {
    Button {
      viewModel.register(withemail: email,
                         password: password,
                         fullname: fullname,
                         username: username)
    } label: {
      Text("Sign Up")
        .font(.headline)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(Color(.systemBlue))
        .clipShape(Capsule())
        .padding()
    }
  }
  
  private func loginButton() -> some View {
    Button {
      presentationMode.wrappedValue.dismiss()
    } label: {
      HStack {
        Text("Already have an account?")
          .font(.footnote)
        
        Text("Sign In")
          .font(.footnote)
          .fontWeight(.semibold)
      }
    }
    .padding(.bottom, 32)
  }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
