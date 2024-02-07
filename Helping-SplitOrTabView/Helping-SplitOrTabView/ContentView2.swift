//
//  ContentView.swift
//  Helping-SplitOrTabView
//
//  Created by Joel Groomer on 2/6/24.
//

import SwiftUI

// DEFINED IN ORIGINAL ContentView.swift
//struct SubView: Identifiable {
//    let id: Int
//}

struct ContentView2: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var selectedSubView: Int? = 1
    private var subViewOptions = [SubView(id: 1), SubView(id: 2), SubView(id: 3)]

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(horizontalSizeClass == .compact ? "Compact" : "Regular")
            if horizontalSizeClass == .compact {
                TabView(selection: $selectedSubView,
                        content:  {
                    Text("Tab Content 1").tabItem { Text("Tab Label 1") }.tag(1)
                    Text("Tab Content 2").tabItem { Text("Tab Label 2") }.tag(2)
                    Text("Tab Content 3").tabItem { Text("Tab Label 3") }.tag(3)
                })
            } else {
                NavigationSplitView {
                    List(subViewOptions, selection: $selectedSubView) {
                        Text("NavSplit Label \($0.id)")
                    }
                } detail: {
                    Text("NavSplit Detail \(selectedSubView ?? 0)")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
