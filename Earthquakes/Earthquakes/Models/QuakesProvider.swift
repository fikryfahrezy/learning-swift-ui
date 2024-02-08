//
//  QuakesProvider.swift
//  Earthquakes-iOS
//
//  Created by Fikry Fahrezy on 05/02/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

@Observable
class QuakesProvider {
    var quakes: [Quake] = []
    
    let client: QuakeClient
    
    func fetchQuakes() async throws {
        let latestQuakes = try await client.quakes
        self.quakes = latestQuakes
    }
    
    func deleteQuakes(atOffsets offests: IndexSet) {
        quakes.remove(atOffsets: offests)
    }
    
    func location(for quake: Quake) async throws -> QuakeLocation {
        return try await client.quakeLocation(from: quake.detail)
    }
    
    init(client: QuakeClient = QuakeClient()) {
        self.client = client
    }
}
