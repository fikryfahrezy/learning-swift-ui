//
//  ContentView.swift
//  RecognizingGesturesMachineLearning
//
//  Created by Fikry Fahrezy on 02/06/24.
//

import SwiftUI

struct ContentView:View {
    @Environment(AppModel.self) var appModel
    
    var body: some View {
        RPSGameView(isMLGame: false)
            .environment(appModel)
    }
}
