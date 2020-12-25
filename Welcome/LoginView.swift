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

struct LoginView: View {
    
    @Binding var loginPressed: Bool
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var errorMessage: String = ""
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
    
    var body: some View {
        if !authenticationDidSucceed {
            VStack {
                HStack {
                    Text("Don't have an account?")
                    Button(action: {
                        withAnimation(.easeOut(duration: 0.3)) {
                            self.loginPressed.toggle()
                        }
                    }) {
                        Text("Go back")
                    }
                }
                EmailTextField(email: $email)
                PasswordTextField(password: $password, isRetype: false)
                
                if authenticationDidFail {
                    Text("Error: \(errorMessage)")
                }
                
                Button(action: {

//                    // Login
//                    Auth.auth().signIn(withEmail: self.email, password: self.password) { (authResult, error) in
//                        if let e = error {
//                            self.errorMessage = e.localizedDescription
//                            self.authenticationDidFail = true
//                        } else {
//                            withAnimation(.easeOut(duration: 0.3)) {
                                self.authenticationDidSucceed = true
//                            }
//                        }
//                    }

                }, label: {
                    Text("Log In")
                })
                    .padding()
                Spacer()
            }
        } else {
            MainUI()
                .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
        }
    }
}

//struct LoginUI_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            LoginUI()
//        }
//    }
//}
