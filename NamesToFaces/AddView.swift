//
//  AddView.swift
//  NamesToFaces
//
//  Created by Milo Wyner on 9/10/21.
//

import SwiftUI

struct AddView: View {
    @Binding var people: [Person]
    
    @State private var name = ""
    @State private var face: Image?
    @State private var showingImagePicker = true
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if let face = face {
            NavigationView {
                VStack {
                    face
                        .resizable()
                        .scaledToFit()
                    TextField("Name", text: $name, onCommit:  {
                        let person = Person(name: name, face: face)
                        people.append(person)
                        presentationMode.wrappedValue.dismiss()
                    })
                    .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.horizontal)
                .navigationTitle(Text("Name the Face"))
            }
        } else {
            ImagePicker(image: $face)
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(people: .constant([]))
    }
}