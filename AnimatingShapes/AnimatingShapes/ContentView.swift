//
//  ContentView.swift
//  AnimatingShapes
//
//  Created by Fikry Fahrezy on 27/05/24.
//

import SwiftUI

struct ContentView: View {
    var contentSource: [Topic]
    
    var body: some View {
        Section {
            List {
                ForEach(contentSource) { row in
                    NavigationLink(
                        destination: Destination.view(forSelection: row.destination), label: {
                            TopicRowView(title: row.title, description: row.description, systemIcon: row.systemSymbol)
                        })
                        .fixedSize(horizontal: false, vertical: true)
                        .listRowInsets(.init(top: 15, leading: 15, bottom: 15, trailing: 15))
                    
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Animating Shapes")
            
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            Color.clear.frame(height: 15)
        }
    }
}

#Preview {
    ContentView(contentSource: TopicData.homeContent)
}
