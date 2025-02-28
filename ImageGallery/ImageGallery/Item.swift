//
//  Item.swift
//  ImageGallery
//
//  Created by Fikry Fahrezy on 25/05/24.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let url: URL
}


extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
