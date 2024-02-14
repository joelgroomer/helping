//
//  CategoriesScreen.swift
//  Helping-asyncAndState
//
//  Created by Joel Groomer on 2/13/24.
//

import SwiftUI

struct CategoriesScreen: View {
    @StateObject var vm = FetchVM(fetch: Api().fakeProductCategories)
    
    var body: some View {
        VStack(alignment: .leading) {
            switch (vm.uiState){
            case .none:
                Color.clear
                // moved fetch to onAppear
            case .loading:
                ProgressView()
            case .failure:
                Text("There was an unknown error.  Please check your internet and try again.")
                Spacer()
                Button("Retry") {
                    vm.asyncFetch()
                }
            case .success(let data):
                Text("Display \(data.first?.id.uuidString ?? "NO ID")")
            }
        }
        .onAppear {
            vm.asyncFetch()
        }
    }
}

#Preview {
    CategoriesScreen()
}
