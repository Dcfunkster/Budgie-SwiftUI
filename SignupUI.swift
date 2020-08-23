//
//  SignupUI.swift
//  Budgie
//
//  Created by Daniel Funk on 2020-08-19.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct SignupUI: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var retypePassword: String = ""
    
    @State var authenticationDidFail: Bool = false
    @State var errorMessage: String = ""
    
    @State var authenticationDidSucceed: Bool = false
    
    var body: some View {
        VStack {
            EmailTextField(email: $email)
            PasswordTextField(password: $password, isRetype: false)
            PasswordTextField(password: $retypePassword, isRetype: true)
            
            // Error message
            if authenticationDidFail {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
            
            NavigationLink(destination: MainUI(), isActive: $authenticationDidSucceed) { EmptyView() }
            // Sign Up Button
            Button(action: {
                
                // Firebase Sign In
                Auth.auth().createUser(withEmail: self.email, password: self.password) { (authResult, error) in
                    if let e = error {
                        self.authenticationDidFail = true
                        self.errorMessage = e.localizedDescription
                    } else if self.password != self.retypePassword {
                        self.authenticationDidFail = true
                        self.errorMessage = "Passwords do not match."
                    } else {
                        // Send user to next MainUI
                        self.authenticationDidSucceed = true
                    }
                }
            }, label: {
                Text("Sign Up")
                    .padding()
            })
            Spacer()
        }

    }
}

struct SignupUI_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignupUI()
        }
    }
}

struct EmailTextField: View {
    
    // The @Binding creates a link between this email and the email passed into it. Every time this email is changed, the original email is too.
    @Binding var email: String
    var body: some View {
        TextField("Email", text: $email)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.leading).padding(.trailing)
    }
}

struct PasswordTextField: View {
    @Binding var password: String
    var isRetype: Bool
    
    var body: some View {
        // ? changes the placeholder text depending on the value of isRetype
        SecureField(isRetype ? "Retype Password" : "Password", text: $password)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.leading).padding(.trailing)
    }
}
