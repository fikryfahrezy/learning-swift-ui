//
//  DatePlannerApp.swift
//  DatePlanner
//
//  Created by Fikry Fahrezy on 18/05/24.
//

import SwiftUI

@main
struct DatePlannerApp: App {
    @State private var eventData = EventData()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                Text("Select an Event")
                    .foregroundStyle(.secondary)
            }
            .environment(eventData)
        }
    }
}
