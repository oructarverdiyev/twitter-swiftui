//
//  LoginView.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 25.07.23.
//

import SwiftUI

struct LoginView: View {
  @State private var email = ""
  @State private var password = ""
  
  @EnvironmentObject var viewModel: AuthViewModel
  
  var body: some View {
    VStack {
      headerView()
      
      textFields()
      
      forgotPasswordButton()
      
      signInButton()
      
      Spacer()
      
      signUpButton()
    }
    .ignoresSafeArea()
    .navigationBarHidden(true)
  }
}

extension LoginView {
  private func headerView() -> some View {
    AuthHeaderView(title1: "Hello.",
                   title2: "Welcome back")
  }
  
  private func textFields() -> some View {
    VStack(spacing: 40) {
      CTextField(imageName: "envelope",
                 placeholderText: "Email",
                 text: $email)
      
      CTextField(imageName: "lock",
                 placeholderText: "Password",
                 isSecureField: true,
                 text: $password)
    }
    .padding(.horizontal, 32)
    .padding(.top, 44)
  }
  
  private func forgotPasswordButton() -> some View {
    HStack {
      Spacer()
      
      NavigationLink {
        Text("Reset password view...")
      } label: {
        Text("Forgot password?")
          .font(.caption)
          .fontWeight(.semibold)
          .foregroundColor(Color(.systemBlue))
          .padding(.top)
          .padding(.trailing, 24)
      }
    }
  }
  
  private func signInButton() -> some View {
    Button {
      viewModel.login(withemail: email,
                      password: password)
    } label: {
      Text("Sign In")
        .font(.headline)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: 50)
        .background(Color(.systemBlue))
        .clipShape(Capsule())
        .padding()
    }
  }
  
  private func signUpButton() -> some View {
    NavigationLink {
      RegistrationView()
    } label: {
      HStack {
        Text("Don't have a account?")
          .font(.footnote)
        
        Text("Sign Up")
          .font(.footnote)
          .fontWeight(.semibold)
      }
    }
    .padding(.bottom, 32)
    .foregroundColor(Color(.systemBlue))
  }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
