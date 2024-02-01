//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Fikry Fahrezy on 16/01/24.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            ScrumsView() {
                Task {
                    do {
                        try await store.save(scrums: store.scrums)
                    } catch {
                        errorWrapper = ErrorWrapper(
                            error: error,
                            guidance: "Try again later."
                        )
                        
                    }
                }
            }
            .environment(store)
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(
                        error: error,
                        guidance: "Scrumdinger will load sample data and continue."
                    )
                }
            }
            .sheet(item: $errorWrapper) {
                store.scrums = DailyScrum.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
