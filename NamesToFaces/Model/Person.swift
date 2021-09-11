//
//  Person.swift
//  NamesToFaces
//
//  Created by Milo Wyner on 9/10/21.
//

import SwiftUI

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let face: Image
}
