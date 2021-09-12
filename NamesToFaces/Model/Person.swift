//
//  Person.swift
//  NamesToFaces
//
//  Created by Milo Wyner on 9/10/21.
//

import SwiftUI

struct Person: Identifiable, Codable {
    enum CodingKeys: CodingKey {
        case id, name, uiImage
    }
    
    private(set) var id = UUID()
    private let uiImage: UIImage
    
    let name: String
    var face: Image {
        get { Image(uiImage: uiImage) }
    }
    
    init(name: String, face: UIImage) {
        self.name = name
        self.uiImage = face
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        
        let jpegData = try container.decode(Data.self, forKey: .uiImage)
        uiImage = UIImage(data: jpegData) ?? UIImage()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
        if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
            try container.encode(jpegData, forKey: .uiImage)
        }
    }
}
