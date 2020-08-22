//
//  SpendingView.swift
//  Budgie-SwiftUI
//
//  Created by Daniel Funk on 2020-08-21.
//  Copyright © 2020 Daniel Funk. All rights reserved.
//

import SwiftUI
import SunburstDiagram

// Create your configuration model
let testConfiguration = SunburstConfiguration(nodes: [
    Node(name: "Walking", showName: false, value: 10.0, backgroundColor: .systemBlue),
    Node(name: "Restaurant", showName: false, value: 30.0, backgroundColor: .red, children: [
        Node(name: "Dessert", showName: false, image: UIImage(named: "croissant"), value: 6.0),
        Node(name: "Dinner", showName: false, image: UIImage(named: "poultry"), value: 10.0),
    ]),
    Node(name: "Transport", showName: false, value: 10.0, backgroundColor: .systemPurple),
    Node(name: "Home", showName: false, value: 50.0, backgroundColor: .systemTeal),
])

struct SpendingView: View {
    
    let viewController = UIHostingController(rootView: SunburstView(configuration: testConfiguration))
    
    var body: some View {
        VStack {
            SunburstView(configuration: testConfiguration)
                .animation(.interactiveSpring())
            Text("Hello")
        }
            .tabItem {
                VStack {
                    Image(systemName: "dollarsign.circle")
                    Text("Spending")
                }
            }
        .tag(0)
    }
    
}

struct SpendingView_Previews: PreviewProvider {
    static var previews: some View {
        SpendingView()
    }
}
