//
//  QuakeDetail.swift
//  Earthquakes-iOS
//
//  Created by Fikry Fahrezy on 08/02/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI

struct QuakeDetail: View {
    var quake: Quake
    
    @Environment(QuakesProvider.self) var quakesProvider
    @State private var location: QuakeLocation? = nil
    @State private var fullprecisionCoordinate = false
    
    var coordinateFormat: FloatingPointFormatStyle<Double> {
        return fullprecisionCoordinate
        ? FloatingPointFormatStyle.number
        : .number.precision(.fractionLength(3))
    }
    
    var body: some View {
        VStack {
            if let location = self.location {
                QuakeDetailMap(location: location, tintColor: quake.color)
                    .ignoresSafeArea(.container)
            }
            QuakeMagnitude(quake: quake)
            Text(quake.place)
                .font(.title3)
                .bold()
            Text("\(quake.time.formatted())")
                .foregroundStyle(Color.secondary)
            if let location = self.location {
                VStack {
                    Text(
                        "Latitude: \(location.latitude.formatted(coordinateFormat))"
                    )
                    Text(
                        "Longitude: \(location.longitude.formatted(coordinateFormat))"
                    )
                }
                .onTapGesture {
                    fullprecisionCoordinate.toggle()
                }
            }
        }
        .task {
            if self.location == nil {
                if let quakeLocation = quake.location {
                    self.location = quakeLocation
                } else {
                    self.location = try? await quakesProvider.location(for: quake)
                }
            }
        }
    }
}

#Preview {
    QuakeDetail(quake: Quake.preview)
        .environment(
            QuakesProvider(
                client: QuakeClient(
                    downloader: TestDownloader()
                )
            )
        )
}
