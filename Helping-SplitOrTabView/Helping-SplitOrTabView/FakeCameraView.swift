//
//  FakeCameraView.swift
//  Helping-SplitOrTabView
//
//  Created by Joel Groomer on 2/6/24.
//

import SwiftUI

struct FakeCameraView: View {
    var body: some View {
        VStack {
            Image("friends")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            HStack {
                Spacer()
                Image(systemName: "xmark.circle")
                    .font(.largeTitle)
                Spacer()
                Image(systemName: "square")
                    .font(.largeTitle)
                Spacer()
                Image(systemName: "play")
                    .font(.largeTitle)
                Spacer()
            }
        }
    }
}

#Preview {
    FakeCameraView()
}
