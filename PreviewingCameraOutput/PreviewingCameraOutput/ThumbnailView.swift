//
//  ThumbnailView.swift
//  PreviewingCameraOutput
//
//  Created by Fikry Fahrezy on 30/05/24.
//

import SwiftUI

struct ThumbnailView: View {
    var image: Image?
    
    var body: some View {
        ZStack {
            Color.white
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(width: 41, height: 41)
        .cornerRadius(11)
    }
}

#Preview {
    let previewImage = Image(systemName: "photo.fill")
    return ThumbnailView(image: previewImage)
}
