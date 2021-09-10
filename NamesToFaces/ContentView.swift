//
//  ContentView.swift
//  NamesToFaces
//
//  Created by Milo Wyner on 9/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddView = false
    @State private var people = [Person]()
    
    var body: some View {
        NavigationView {
            List(people) { person in
                HStack {
                    person.face
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text(person.name)
                        .font(.title3)
                }
            }
            .navigationTitle(Text("Names to Faces"))
            .navigationBarItems(trailing: Button("Add") {
                showingAddView = true
            })
            .sheet(isPresented: $showingAddView, content: {
                AddView(people: $people)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
