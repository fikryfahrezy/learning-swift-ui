//
//  AnimatingShapesApp.swift
//  AnimatingShapes
//
//  Created by Fikry Fahrezy on 27/05/24.
//

import SwiftUI

@main
struct AnimatingShapesApp: App {
    @State var selection: Topic? = nil
    
    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                ContentView(contentSource: TopicData.homeContent)
            } detail: {
                Text("Please select a destination")
            }
        }
    }
}
