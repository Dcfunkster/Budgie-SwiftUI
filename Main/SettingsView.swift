//
//  SettingsView.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-22.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @State private var alertState: Bool = false
    @State private var alertMessage: String = ""
    @State private var logoutSuccessful: Bool = false
    
    var body: some View {
        ZStack {
            Form {
                Section(header: Text("Section Header")) {
                    NavigationLink(destination: WelcomeUI()) {
                        Text("Setting Option")
                    }
                }
                Section {
                    Button("Log Out") {
                        self.logout()
                    }
                    .foregroundColor(.red)
                }
            }
            NavigationLink(destination: WelcomeUI(), isActive: $logoutSuccessful) { EmptyView() }
        }
            
        /// Error message if logout unsuccessful
        .alert(isPresented: $alertState) {
            Alert(title: Text("Logout Error"), message: Text("There was an error logging you out, please try again later."), dismissButton: .default(Text("OK")))
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            self.alertState = true
            self.alertMessage = error.localizedDescription
        }
        if !self.alertState {
            self.logoutSuccessful = true
            print("Logout successful")
        }
    }
}
