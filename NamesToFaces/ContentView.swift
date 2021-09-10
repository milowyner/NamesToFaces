//
//  ContentView.swift
//  NamesToFaces
//
//  Created by Milo Wyner on 9/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(0..<3) { _ in
                HStack {
                    Image("TestPhoto")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Text("First Last")
                        .font(.title3)
                }
            }
            .navigationTitle(Text("Names to Faces"))
            .navigationBarItems(trailing: Button("Add") {
                // open image picker
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
