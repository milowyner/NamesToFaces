//
//  Image+ClipSquare.swift
//  NamesToFaces
//
//  Created by Milo Wyner on 9/11/21.
//

import SwiftUI

extension Image {
    func clipSquare() -> some View {
        GeometryReader { geometry in
            self
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.width)
                .clipped()
        }
        .aspectRatio(1, contentMode: .fit)
    }
}
