//
//  DetailView.swift
//  ImageGallery
//
//  Created by Fikry Fahrezy on 25/05/24.
//

import SwiftUI

struct DetailView: View {
    let item: Item

    var body: some View {
        AsyncImage(url: item.url) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}
