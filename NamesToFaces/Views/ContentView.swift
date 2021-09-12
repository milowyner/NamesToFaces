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
    
    static let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("people.json")
    
    var body: some View {
        NavigationView {
            List(people) { person in
                NavigationLink(destination: DetailView(person: person)) {
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
            .sheet(isPresented: $showingAddView, onDismiss: save, content: {
                AddView(people: $people)
            })
        }
        .onAppear(perform: load)
    }
    
    func load() {
        do {
            let data = try Data(contentsOf: Self.path)
            people = try JSONDecoder().decode([Person].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: Self.path)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
