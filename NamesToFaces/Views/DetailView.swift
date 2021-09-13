//
//  DetailView.swift
//  NamesToFaces
//
//  Created by Milo Wyner on 9/11/21.
//

import SwiftUI
import CoreLocation

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
            
            if let location = person.location {
                MapView(centerCoordinate: location)
                    .cornerRadius(10)
                    .ignoresSafeArea(.keyboard)
                    .layoutPriority(-1)
            } else {
                Spacer()
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(person: Person(name: "First Last", face: UIImage(named: "TestPhoto")!, location: CLLocationCoordinate2D(latitude: 0, longitude: 0)))
        }
    }
}
