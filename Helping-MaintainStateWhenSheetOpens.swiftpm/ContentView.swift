import SwiftUI
import Foundation

@available(iOS 17.0, *)
class MainViewModel: ObservableObject {
    @Published var showMainSheet = false
    @Published var selectedDetent: PresentationDetent = .fraction(0.25)
    @Published var showSubSheetA = false // Manage the bottom sheet's subview presentation state
    
    @Published var showSubSheetB = false
}

@available(iOS 17.0, *)
struct ContentView: View {
    @StateObject var mainViewModel: MainViewModel = MainViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("This is the main view").padding(.top, 100.0)
                Spacer()
            }
            .onAppear {
                mainViewModel.showMainSheet = true
            }
            .overlay(alignment: .bottomTrailing) {
                self.infoView
            }
            .sheet(isPresented: $mainViewModel.showMainSheet) {
                ZStack {
                    Color.gray.opacity(0.5)
                    MainSheetView().padding(.top, 15.0).environmentObject(mainViewModel)
                }
            }
        }
    }
    
    private var infoView: some View {
        InfoView().padding(.bottom, 210.0).padding(.trailing, 10.0)
    }
}

// MARK: View's related to main sheet.
@available(iOS 17.0, *)
struct MainSheetView: View {
    @EnvironmentObject var mainViewModel: MainViewModel
//    @StateObject var subSheetAViewModel: SubSheetAViewModel = SubSheetAViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.teal.opacity(0.5).edgesIgnoringSafeArea(.all)
                VStack {
                    Button {
                        mainViewModel.showSubSheetA = true // Use the view model's state
                    } label: {
                        Text("Click Me")
                    }
                }
                .navigationDestination(isPresented: $mainViewModel.showSubSheetA) { // Use the view model's state
                    SubSheetA() //.environmentObject(subSheetAViewModel)
                }
            }
        }
        .presentationDetents([.fraction(0.25), .large], selection: $mainViewModel.selectedDetent)
        .interactiveDismissDisabled(true)
        .presentationBackgroundInteraction(.enabled)
    }
}

// MARK: View's and view model related to sub sheet A
@available(iOS 17.0, *)
class SubSheetAViewModel: ObservableObject {
    @Published var showSubSheetB = false
}

@available(iOS 17.0, *)
struct SubSheetA: View {
    @EnvironmentObject var subSheetAViewModel: SubSheetAViewModel
    
    var body: some View {
        ZStack {
            Color.indigo.opacity(0.5).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Sub sheet A")
                
                Button { subSheetAViewModel.showSubSheetB = true } label: {
                    Text("Open sub sheet B")
                }
            }
            .navigationDestination(isPresented: $subSheetAViewModel.showSubSheetB) { // Use the view model's state
                SubSheetB()
            }
        }
    }
}

// MARK: View related to sub sheet B
@available(iOS 17.0, *)
struct SubSheetB: View {
    var body: some View {
        VStack {
            Text("Sub view B - should stay active.")
        }
    }
}

// MARK: View's related to info view/info button on content view.
@available(iOS 17.0, *)
struct InfoView: View {
    @State var showInfoSubView = false
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                showInfoSubView = true
            } label: {
                Image(systemName: "info.circle.fill").resizable().foregroundColor(.blue).frame(width: 30, height: 30)
            }
        }
        .sheet(isPresented: $showInfoSubView) {
            InfoSubView()
        }
    }
}

@available(iOS 17.0, *)
struct InfoSubView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("This is info sub view... tap on cancel button")
            }
            .presentationDetents([.large])
            .interactiveDismissDisabled(true)
            .presentationBackgroundInteraction(.enabled)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel").font(.body)
                    }
                }
            }
        }
    }
}
