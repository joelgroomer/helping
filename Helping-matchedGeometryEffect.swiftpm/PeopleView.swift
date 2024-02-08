//
//  PeopleView.swift
//  Helping-matchedGeometryEffect
//
//  Created by @Astro on 2/7/24.
//

import SwiftUI

struct PeopleView: View {
    
    struct Person: Identifiable {
        let id: UUID = UUID()
        let first: String
        let last: String
    }
    
    @Namespace var animationNamespace
    
    @State private var isDetailPresented = false
    @State private var selectedPerson: Person? = nil
    
    let people: [Person] = [
        Person(first: "John", last: "Doe"),
        Person(first: "Jane", last: "Doe")
    ]
    
    var body: some View {
        homeView
            .overlay {
                if isDetailPresented, let selectedPerson {
                    detailView(person: selectedPerson)
                        .transition(.asymmetric(insertion: .identity, removal: .offset(y: 5)))
                }
            }
    }
    
    var homeView: some View {
        ScrollView {
            VStack {
                cardScrollView
            }
        }
    }
    
    var cardScrollView: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(people) { person in
                    if !isDetailPresented {
                        personView(person: person, size: 100)
                            .onTapGesture {
                                withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.8, blendDuration: 0.8)){
                                    self.selectedPerson = person
                                    self.isDetailPresented = true
                                }
                            }
                    }
                    else {
                        Rectangle()
                            .frame(width: 50, height: 100)
                    }
                }
            }
        }
    }
    
    func personView(person: Person, size: CGFloat) -> some View {
        Group {
            Text(person.first)
                .padding()
                .frame(height: size)
                .background(Color.gray)
                .cornerRadius(5)
                .shadow(radius: 5)
        }
        .matchedGeometryEffect(id: person.id, in: animationNamespace)
    }
    
    func detailView(person: Person) -> some View {
        VStack {
            personView(person: person, size: 300)
            Text(person.first + " " + person.last)
        }
        .onTapGesture {
            withAnimation {
                self.isDetailPresented = false
                self.selectedPerson = nil
            }
        }
    }
}

#Preview {
    PeopleView()
}
