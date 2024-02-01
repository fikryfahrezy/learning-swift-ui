//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by Fikry Fahrezy on 17/01/24.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}


extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}

#Preview {
    Label("Hello", systemImage: "clock")
        .labelStyle(.trailingIcon)
}
