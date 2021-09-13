//
//  LocationFetcher.swift
//  NamesToFaces
//
//  Created by Milo Wyner on 9/12/21.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager = CLLocationManager()
    
    private var requested = false
    private var onComplete: (CLLocationCoordinate2D?) -> () = { _ in }

    override init() {
        super.init()
        manager.delegate = self
    }

    func start(onComplete: @escaping (CLLocationCoordinate2D?) -> ()) {
        print("Starting.")
        self.onComplete = onComplete
        
        switch manager.authorizationStatus {
        case .notDetermined:
            print("Auth status not determined. Requesting.")
            manager.requestWhenInUseAuthorization()
            requested = true
        case .authorizedWhenInUse, .authorizedAlways:
            print("Updating location.")
            manager.startUpdatingLocation()
        default:
            print("Location denied.")
            complete(nil)
        }
    }
    
    private func complete(_ location: CLLocationCoordinate2D?) {
        manager.stopUpdatingLocation()
        onComplete(location)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location successful.")
        complete(locations.first?.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let errorCode = (error as! CLError).code
        if errorCode == .locationUnknown {
            print("Failed. Unknown location.")
        } else {
            print("Unknown error. Auth status: \(manager.authorizationStatus.rawValue), errorCode: \(errorCode.rawValue)")
        }
        
        complete(nil)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if requested == true {
            if manager.authorizationStatus == .authorizedWhenInUse {
                print("Auth status changed to whenInUse. Updating location.")
                requested = false
                manager.startUpdatingLocation()
            } else if manager.authorizationStatus == .denied {
                print("Auth status changed to denied.")
                requested = false
                complete(nil)
            }
        }
    }
}
