//
//  LoginUI.swift
//  Budgie
//
//  Created by Daniel Funk on 2020-08-19.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginUI: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @State var errorMessage: String = ""
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
    
    var body: some View {
        VStack {
            EmailTextField(email: $email)
            PasswordTextField(password: $password, isRetype: false)
            
            if authenticationDidFail {
                Text("Error: \(errorMessage)")
            }
            
            NavigationLink(destination: MainUI(selectedTab: .add), isActive: $authenticationDidSucceed) { EmptyView() }
            Button(action: {
                
                // Login
                Auth.auth().signIn(withEmail: self.email, password: self.password) { (authResult, error) in
                    if let e = error {
                        self.errorMessage = e.localizedDescription
                        self.authenticationDidFail = true
                    } else {
                        self.authenticationDidSucceed = true
                    }
                }
                
            }, label: {
                Text("Log In")
            })
                .padding()
            Spacer()
        }.navigationTitle("LoginUI")
        .navigationBarHidden(false)
    }
}

struct LoginUI_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginUI()
        }
    }
}
