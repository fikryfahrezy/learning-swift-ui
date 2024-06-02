//
//  MemeCreatorApp.swift
//  MemeCreator
//
//  Created by Fikry Fahrezy on 26/05/24.
//

import SwiftUI

@main
struct MemeCreatorApp: App {
    @State private var fetcher = PandaCollectionFetcher()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(fetcher)
        }
    }
}
