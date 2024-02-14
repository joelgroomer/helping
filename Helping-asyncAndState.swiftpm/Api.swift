//
//  Api.swift
//  Helping-asyncAndState
//
//  Created by Joel Groomer on 2/13/24.
//

import Foundation

public struct Api {
    public func fakeProductCategories() async throws -> [CategoryItem]? {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return [
            CategoryItem(id: UUID())
        ]
    }
}
