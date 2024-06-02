//
//  HomeView.swift
//  AboutMe
//
//  Created by Fikry Fahrezy on 17/05/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("All About")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            
            Image(information.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding(40)
            
            
            Text(information.name)
                .font(.title)
        }
        
    }
}

#Preview {
    HomeView()
}
