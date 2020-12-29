//
//  WelcomeUI.swift
//  Budgie
//
//  Created by Daniel Funk on 2020-08-19.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI

struct WelcomeUI: View {
    
    // Organized into two views: WelcomeUI/(SignupUI/LoginUI)
    
    @State private var signupPressed = false
    @State private var loginPressed = false
    
    var body: some View {
        ZStack {
            if !signupPressed && !loginPressed {
                WelcomeView(signupPressed: $signupPressed, loginPressed: $loginPressed)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
            } else if signupPressed {
                SignupView(signupPressed: $signupPressed)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else if loginPressed {
                LoginView(loginPressed: $loginPressed)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
    }
}

struct WelcomeView: View {
    @Binding var signupPressed: Bool
    @Binding var loginPressed: Bool
    
    var authenticationPressed: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("Budgie")
                .font(.largeTitle)
            Image("budgie_sample")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Spacer()
            
            Button(action: {
                withAnimation(.easeOut(duration: 0.3)) {
                    self.signupPressed.toggle()
                }
            }) {
                Spacer()
                Text("Sign Up")
                Spacer()
            }
            .padding(.top).padding(.bottom)
            .background(Color.blue)
            .foregroundColor(.white)
            
            Button(action: {
                withAnimation(.easeOut(duration: 0.3)) {
                    self.loginPressed.toggle()
                }
            }) {
                Spacer()
                Text("Log In")
                Spacer()
            }
            .padding(.top).padding(.bottom)
            .background(Color.purple)
            .foregroundColor(.white)
        }
    }
}
