//
//  LayingOutViewsApp.swift
//  LayingOutViews
//
//  Created by Fikry Fahrezy on 25/05/24.
//

import SwiftUI

@main
struct LayingOutViewsApp: App {
    @State var journalData = JournalData()
    var body: some Scene {
        WindowGroup {
            ContentView(journalData: journalData)
                .task {
                    journalData.load()
                }
                .onChange(of: journalData.entries) {
                    journalData.save()
                }
        }
    }
}
