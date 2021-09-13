//
//  AddView.swift
//  NamesToFaces
//
//  Created by Milo Wyner on 9/10/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @Binding var people: [Person]
    @State var face: UIImage?
    
    @State private var name = ""
    
    private let locationFetcher = LocationFetcher()
    
    var body: some View {
        if let face = face {
            NavigationView {
                VStack {
                    Image(uiImage: face)
                        .clipSquare()
                        .cornerRadius(10)
                        .onTapGesture {
                            self.face = nil
                        }
                    TextField("Name", text: $name, onCommit:  {
                        locationFetcher.start(onComplete: { location in
                            let person = Person(name: name, face: face, location: location)
                            people.append(person)
                            presentationMode.wrappedValue.dismiss()
                        })
                    })
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .padding(.vertical, 8)
                    
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
        AddView(people: .constant([]), face: UIImage(named: "TestPhoto"))
    }
}
