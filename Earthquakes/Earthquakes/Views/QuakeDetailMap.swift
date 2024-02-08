//
//  QuakeDetailMap.swift
//  Earthquakes-iOS
//
//  Created by Fikry Fahrezy on 08/02/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI
import MapKit

struct QuakeDetailMap: View {
    let location: QuakeLocation
    let tintColor: Color
    private let place: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()
    
    
    init(location: QuakeLocation, tintColor: Color) {
        self.location = location
        self.tintColor = tintColor
        self.place = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }
    
    var body: some View {
        Map(position: .constant(.region(region))) {
            Marker(coordinate: self.place) {}
                .tint(tintColor)
            Annotation(
                coordinate: self.place,
                content: {},
                label: {}
            )
        }
        .onAppear {
            withAnimation {
                region.center = self.place
                region.span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            }
        }
    }
}
