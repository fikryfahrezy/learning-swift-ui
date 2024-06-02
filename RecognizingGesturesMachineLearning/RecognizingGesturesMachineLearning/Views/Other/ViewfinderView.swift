//
//  ViewfinderView.swift
//  RecognizingGesturesMachineLearning
//
//  Created by Fikry Fahrezy on 02/06/24.
//

import SwiftUI

struct ViewfinderView: View {
    var image: Image?
    
    var body: some View {
        GeometryReader { geometry in
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            } else {
                Rectangle()
                    .fill(.black)
            }
        }
    }
}
