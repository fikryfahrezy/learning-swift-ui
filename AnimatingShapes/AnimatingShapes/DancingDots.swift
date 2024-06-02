//
//  DancingDots.swift
//  AnimatingShapes
//
//  Created by Fikry Fahrezy on 27/05/24.
//

import SwiftUI

@Observable class SmallDot : Identifiable {
    let id = UUID()
    
    var offset : CGSize = .zero
    var color : Color = .primary
}

@Observable class BigDot : Identifiable {
    let id = UUID()
    
    var offset: CGSize = .zero
    var color: Color = .primary
    var scale: Double = 1.0
    var smallDots = [SmallDot]()
    
    init() {
        for _ in 0..<5 {
            smallDots.append(SmallDot())
        }
    }
    
    func randomizePositions() {
        for dot in smallDots {
            dot.offset = CGSize(width: Double.random(in: -120...120), height: Double.random(in: -120...120))
            dot.color = DotTracker.randomColor
        }
    }
    
    func resetPositions() {
        for dot in smallDots {
            dot.offset = .zero
            dot.color = .primary
        }
    }
    
}

@Observable class DotTracker {
    var bigDots = [BigDot]()
    
    static var colors: [Color] = [.pink, .purple, .mint, .blue, .yellow, .red, .teal, .cyan]
    static var randomColor: Color {
        colors.randomElement() ?? .blue
    }
    
    init() {
        for _ in 0..<100 {
            bigDots.append(BigDot())
        }
    }
    
    func randomizePositions() {
        for bigDot in bigDots {
            bigDot.offset = CGSize(width: Double.random(in: -50...50), height: Double.random(in: -50...50))
            bigDot.scale = 2.5
            bigDot.color = DotTracker.randomColor
            bigDot.randomizePositions()
        }
    }
    
    func resetPositions() {
        for bigDot in bigDots {
            bigDot.offset = .zero
            bigDot.scale = 1.0
            bigDot.color = DotTracker.randomColor
            bigDot.resetPositions()
        }
    }
    
}

struct DancingDotsView: View {
    private var columns = Array(repeating: GridItem(.flexible()), count: 10)
    @State var tracker = DotTracker()
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Spacer()
            LazyVGrid(columns: columns) {
                ForEach(tracker.bigDots) { bigDot in
                    ZStack {
                        Circle()
                            .offset(bigDot.offset)
                            .foregroundColor(bigDot.color)
                            .scaleEffect(bigDot.scale)
                        ForEach(bigDot.smallDots) { smallDot in
                            Circle()
                                .offset(smallDot.offset)
                                .foregroundColor(smallDot.color)
                        }
                    }
                }
            }
            .frame(minHeight: 500)
            .drawingGroup()
            Spacer()
            PlayResetButton(animating: $isAnimating) {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.5, blendDuration: 1).repeatForever()) {
                    if isAnimating {
                        tracker.randomizePositions()
                    } else {
                        tracker.resetPositions()
                    }
                }
            }
        }
        .navigationTitle("Dancing Dots")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DancingDotsView()
}
