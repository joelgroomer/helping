//
//  FetchVM.swift
//  Helping-asyncAndState
//
//  Created by Joel Groomer on 2/13/24.
//

import Foundation

enum FetchState<T> {
    case none, loading, success(T), failure
}

@MainActor class FetchVM<T> : ObservableObject {
    private var fetch: () async throws -> T?
    
    init(fetch: @escaping () async throws -> T?) {
        self.fetch = fetch
    }
    
    @Published var uiState: FetchState<T> = FetchState.none
    
    public func asyncFetch() {
        uiState = FetchState.loading
        Task {
            do {
                guard let response = try await fetch() else {return}
                uiState = FetchState.success(response)
            } catch let error {
                print(error.localizedDescription)
                uiState = FetchState.failure
            }
        }
    }
}
