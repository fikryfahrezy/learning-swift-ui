//
//  ImageGalleryApp.swift
//  ImageGallery
//
//  Created by Fikry Fahrezy on 25/05/24.
//

import SwiftUI

@main
struct ImageGalleryApp: App {
    @State var dataModel = DataModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .environment(dataModel)
            .navigationViewStyle(.stack)
        }
    }
}
