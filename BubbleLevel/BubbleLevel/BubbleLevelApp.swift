//
//  BubbleLevelApp.swift
//  BubbleLevel
//
//  Created by Fikry Fahrezy on 26/05/24.
//

import SwiftUI

@main
struct BubbleLevelApp: App {
    @State var motionDetector = MotionDetector(updateInterval: 0.01)
    var body: some Scene {
        WindowGroup {
            ContentView().environment(motionDetector)
        }
    }
}
