//
//  PeopleView.swift
//  Helping-matchedGeometryEffect
//
//  Created by @julltron on 2/7/24.
//

import SwiftUI

struct Person: Identifiable, Equatable {   // Added Equatable. You could compare `.id`s below instead
    let id: UUID = UUID()
    let first: String
    let last: String
}

struct PeopleView2: View {
    @Namespace var animationNamespace
    
    @State private var isDetailPresented = false
    @State private var selectedPerson: Person? = nil
    
    let people: [Person] = [
        Person(first: "John", last: "Doe"),
        Person(first: "Jane", last: "Doe")
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(people) { person in
                            //  if !isDetailPresented {
                            if person != selectedPerson {
                                PersonView(person: person, size: 100)
                                    .matchedGeometryEffect(id: person.id, in: animationNamespace)
                                    .onTapGesture {
                                        withAnimation(.interactiveSpring(
                                            response: 0.3,
                                            dampingFraction: 0.8,
                                            blendDuration: 0.8)){
                                                self.selectedPerson = person
                                                self.isDetailPresented = true
                                            }
                                    }
                            } 
//                            else {
//                            }
                        }
                    }
                }
            }
            .overlay {
                if isDetailPresented, let selectedPerson {
//                    VStack {
                        PersonView(person: selectedPerson, size: 300)
//                            .transition(.asymmetric(insertion: .identity, removal: .offset(y: 5)))
                            .matchedGeometryEffect(id: selectedPerson.id, in: animationNamespace)
                            .onTapGesture {
                                withAnimation(.interactiveSpring(
                                    response: 0.3,
                                    dampingFraction: 0.8,
                                    blendDuration: 0.8)) {
                                        self.selectedPerson = nil
                                        self.isDetailPresented = false
                                    }
                            }
                        
//                        Text(selectedPerson.first + " " + selectedPerson.last)
//                    }
                }
            }
        }
    }
}

struct PersonView: View {
    let person: Person
    let size: CGFloat
    
    var body: some View {
        Text(person.first)
            .padding()
            .frame(height: size)
            .background(Color.gray)
            .cornerRadius(5)
            .shadow(radius: 5)
    }
}

#Preview {
    PeopleView2()
}
