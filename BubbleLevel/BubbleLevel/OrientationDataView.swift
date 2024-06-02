//
//  OrientationDataView.swift
//  BubbleLevel
//
//  Created by Fikry Fahrezy on 26/05/24.
//

import SwiftUI

struct OrientationDataView: View {
    @Environment(MotionDetector.self) var detector
    
    
    var rollString: String {
        detector.roll.describeAsFixedLengthString()
    }
    
    
    var pitchString: String {
        detector.pitch.describeAsFixedLengthString()
    }
    
    
    var body: some View {
        VStack {
            Text("Horizontal: " + rollString)
                .font(.system(.body, design: .monospaced))
            Text("Vertical: " + pitchString)
                .font(.system(.body, design: .monospaced))
        }
    }
}

#Preview {
    @State var motionDetector = MotionDetector(updateInterval: 0.01).started()
    return OrientationDataView().environment(motionDetector)
}
