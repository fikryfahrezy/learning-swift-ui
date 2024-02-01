//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Fikry Fahrezy on 17/01/24.
//

import SwiftUI

struct ScrumsView: View {
    @Environment(ScrumStore.self) private var scrumStore
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrumView = false
    let saveAction: ()->Void
    
    var body: some View {
        @Bindable var scrumStore = scrumStore
        
        return NavigationStack {
            List($scrumStore.scrums) { $scrum in
                NavigationLink {
                    DetailView(scrum: $scrum)
                } label: {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button {
                    isPresentingNewScrumView = true
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet(
                scrums: $scrumStore.scrums,
                isPresentingNewScrumView: $isPresentingNewScrumView
            )
        }
        .onChange(of: scenePhase) {
            if scenePhase == .inactive {
                saveAction()
            }
        }
    }
}

// A View that simply wraps the real view we're working on
// Its only purpose is to hold state
struct ScrumsViewContainer: View {
    @State private var scrumStore = ScrumStore()
    
    init() {
        self.scrumStore.scrums = DailyScrum.sampleData
    }
    
    var body: some View {
        ScrumsView(saveAction: {})
            .environment(scrumStore)
    }
}

#Preview("Static") {
    var scrumStore = ScrumStore()
    scrumStore.scrums = DailyScrum.sampleData
    return ScrumsView(saveAction: {}).environment(scrumStore)
}

#Preview("Interaction") {
    ScrumsViewContainer()
}
