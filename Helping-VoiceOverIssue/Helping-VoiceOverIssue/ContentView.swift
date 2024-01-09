//
//  ContentView.swift
//  SwiftUI-Experiments
//
//  Created by Joel Groomer on 1/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                AnotherView()
            } label: {
                Text("Tap here to navigate")
                // works when VO is off
                    .simultaneousGesture(TapGesture().onEnded {
                        print("tapped and 2nd gesture captured")
                    })
            }
            .accessibilityAction {
                // works when VO is on
                print("VO selected btn")
            }
        }
    }
}

struct AnotherView: View {
    var body: some View {
        Text("Second view")
    }
}

#Preview {
    ContentView()
}
