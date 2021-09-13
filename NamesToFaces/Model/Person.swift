//
//  Person.swift
//  NamesToFaces
//
//  Created by Milo Wyner on 9/10/21.
//

import SwiftUI
import CoreLocation

struct Person: Identifiable, Codable {
    enum CodingKeys: CodingKey {
        case id, name, uiImage, latitude, longitude
    }
    
    let name: String
    var face: Image {
        Image(uiImage: uiImage)
    }
    let location: CLLocationCoordinate2D?
    
    private(set) var id = UUID()
    private let uiImage: UIImage
    
    init(name: String, face: UIImage, location: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.uiImage = face
        self.location = location
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        let jpegData = try container.decode(Data.self, forKey: .uiImage)
        uiImage = UIImage(data: jpegData) ?? UIImage()
        
        if let latitude = try? container.decode(CLLocationDegrees.self, forKey: .latitude),
           let longitude = try? container.decode(CLLocationDegrees.self, forKey: .longitude) {
            location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            location = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
        if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
            try container.encode(jpegData, forKey: .uiImage)
        }
        
        if let location = location {
            try container.encode(location.latitude, forKey: .latitude)
            try container.encode(location.longitude, forKey: .longitude)
        }
    }
}
