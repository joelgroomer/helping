// Question asked by tech_human on StackOverflow
// https://stackoverflow.com/questions/77998161/maintain-state-of-sheet-when-another-sheet-is-opened-on-top-of-it/77998633#77998633


import SwiftUI

@available(iOS 17.0, *)
@main
struct MyApp: App {
    @StateObject var subSheetAViewModel = SubSheetAViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(subSheetAViewModel)
    }
}
