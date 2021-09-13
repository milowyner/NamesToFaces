//
//  MapView.swift
//  NamesToFaces
//
//  Created by Milo Wyner on 9/12/21.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let centerCoordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.centerCoordinate = centerCoordinate
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    }
}
