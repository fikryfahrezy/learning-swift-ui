//
//  MLTrainingApp.swift
//  MLTraining
//
//  Created by Fikry Fahrezy on 02/06/24.
//

import SwiftUI

@main
struct MLTrainingApp: App {
    @State var appModel = AppModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
        }
    }
}
