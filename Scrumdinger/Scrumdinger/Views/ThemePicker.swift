//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by Fikry Fahrezy on 21/01/24.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
                
            }
        }
        .pickerStyle(.navigationLink)
    }
}

#Preview {
    NavigationStack {
        ThemePicker(selection: .constant(.periwinkle))
    }   
}
