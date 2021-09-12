//
//  DetailView.swift
//  NamesToFaces
//
//  Created by Milo Wyner on 9/11/21.
//

import SwiftUI

struct DetailView: View {
    let person: Person
    
    var body: some View {
        VStack {
            person.face
                .clipSquare()
                .cornerRadius(10)
            
            Text(person.name)
                .font(.title)
                .padding(8)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(person: Person(name: "Michael C. Jordan", face: UIImage(named: "TestPhoto")!))
        }
    }
}
