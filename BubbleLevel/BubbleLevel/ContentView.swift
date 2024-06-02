//
//  LevelView.swift
//  BubbleLevel
//
//  Created by Fikry Fahrezy on 26/05/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(MotionDetector.self) var motionDetector
    
    var body: some View {
        VStack {
            BubbleLevel()
            OrientationDataView()
                .padding(.top, 80)
        }
        .onAppear {
            motionDetector.start()
        }
        .onDisappear {
            motionDetector.stop()
        }
    }
}

#Preview {
    @State var motionDetector = MotionDetector(updateInterval: 0.01).started()
    return ContentView().environment(motionDetector)
}
