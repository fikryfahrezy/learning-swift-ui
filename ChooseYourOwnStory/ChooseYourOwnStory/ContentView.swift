//
//  ContentView.swift
//  ChooseYourOwnStory
//
//  Created by Fikry Fahrezy on 18/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            StoryPageView(story: story, pageIndex: 0)
        }
    }
}

#Preview {
    ContentView()
}
