//
//  ContentView.swift
//  Helping-CurvedHeader
//
//  Created by Joel Groomer on 1/24/24.
//

import SwiftUI

struct ArcMask: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 55))
            
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.minY - rect.width),
                radius: rect.width * 1.55,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image("banner")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: 200)
                    .overlay(content: {
                        Color.black.opacity(0.35)
                    })
                    .mask(ArcMask())
            }
            .frame(height: 200)
            
            ZStack {
                Circle()
                    .foregroundStyle(.white)
                    .frame(width: 120, height: 120)
                    .offset(y: -55)
                
                Circle()
                    .foregroundStyle(.yellow)
                    .frame(width: 110, height: 110)
                    .offset(y: -55)
            }
            
            Text("Good Afternoon, Alexandar")
                .font(.title.bold())
                .padding(.top, -40)
            
            Spacer()
        }
        
    }
}

#Preview {
    ContentView()
}
