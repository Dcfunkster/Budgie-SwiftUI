//
//  WelcomeUI.swift
//  Budgie
//
//  Created by Daniel Funk on 2020-08-19.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI

struct WelcomeUI: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Budgie")
                    .font(.largeTitle)
                Image("budgie_sample")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                // Sign Up button
                NavigationLink(destination: SignupUI(), label: {
                    Spacer()
                    Text("Sign Up")
                    Spacer()
                })
                .padding(.top).padding(.bottom)
                .background(Color.blue)
                .foregroundColor(.white)
                
                // Log In button
                NavigationLink(destination: LoginUI(), label: {
                    Spacer()
                    Text("Log In")
                    Spacer()
                })
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
            }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        }
    }
}

struct WelcomeUI_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeUI()
    }
}
