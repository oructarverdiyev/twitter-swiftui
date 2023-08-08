//
//  CTextField.swift
//  Twitter
//
//  Created by Oruc Tarverdiyev on 25.07.23.
//

import SwiftUI

struct CTextField: View {
  let imageName: String
  let placeholderText: String
  var isSecureField: Bool = false
  @Binding var text: String
  
    var body: some View {
      VStack {
        HStack {
          Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 20,  height: 20)
            .foregroundColor(Color(.systemBlue))
          
          if isSecureField {
            SecureField(placeholderText, text: $text)
          } else {
            TextField(placeholderText, text: $text)
              .autocorrectionDisabled(true)
              .textInputAutocapitalization(.never)
          }
          
        }
        
        Divider()
          .background(Color(.systemBlue))
      }
    }
}

struct CTextField_Previews: PreviewProvider {
    static var previews: some View {
      CTextField(imageName: "envelope",
                 placeholderText: "Email",
                 text: .constant(""))
    }
}
