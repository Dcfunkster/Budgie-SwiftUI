//
//  ContentView.swift
//  Test
//
//  Created by Daniel Funk on 2020-08-21.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import Firebase

struct MainUI: View {
    @State var selection = 0
 
    var body: some View {
        TabView(selection: $selection) {
            SpendingView()
            SavingView()
            AddView()
            EditView()
            SettingsView()
        }
    }
}

struct MainUI_Previews: PreviewProvider {
    static var previews: some View {
        MainUI(selection: 4)
    }
}

//MARK: - TabViews
struct SpendingView: View {
    var body: some View {
        Text("First View")
            .font(.title)
            .tabItem {
                VStack {
                    Image(systemName: "dollarsign.circle")
                    Text("Spending")
                }
        }
        .tag(0)
    }
}

struct SavingView: View {
    var body: some View {
        Text("Second View")
            .font(.title)
            .tabItem {
                VStack {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Saving")
                }
        }
        .tag(1)
    }
}

struct AddView: View {
    var body: some View {
        Text("First View")
            .font(.title)
            .tabItem {
                VStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add")
                }
        }
        .tag(2)
    }
}

struct EditView: View {
    var body: some View {
        Text("First View")
            .font(.title)
            .tabItem {
                VStack {
                    Image(systemName: "pencil.circle.fill")
                    Text("Edit")
                }
        }
        .tag(3)
    }
}

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
            .tag(4)
            // Error message if logout unsuccessful
            .alert(isPresented: $alertState) {
                Alert(title: Text("Logout Error"), message: Text("There was an error logging you out, please try again later."), dismissButton: .default(Text("OK")))
            }
        .tabItem {
            VStack {
                Image(systemName: "gear")
                Text("Settings")
            }
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
