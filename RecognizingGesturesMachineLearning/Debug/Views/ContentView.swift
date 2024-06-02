//
//  ContentView.swift
//  Debug
//
//  Created by Fikry Fahrezy on 02/06/24.
//

import SwiftUI
import Charts

struct ContentView: View {
    @Environment(AppModel.self) var appModel
    
    private var livePredictionData: [PredictionMetric] {
        return appModel.predictionProbability.data
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                CameraView(showNodes: true)
                    .environment(appModel)
                    .overlay(alignment: .bottomTrailing) {
                        PredictionLabelOverlay(label: appModel.predictionLabel, showIcon: false)
                    }
                predictionBarChart()
            }
            .task {
                await appModel.findExistingModels()
            }
            .toolbar {
                availableMLModelsToolbarItem()
            }
        }
        .accentColor(.accent)
    }
    
    private func predictionBarChart() -> some View {
        VStack {
            Chart(livePredictionData, id: \.category) {
                BarMark(xStart: .value("zero", 0.0),
                        xEnd: .value("Probability", $0.value),
                        y: .value("Category", $0.category))
            }
            .chartXScale(domain: 0...1)
            .chartXAxisLabel("Confidence")
            .chartXAxis(.visible)
            .chartYAxis(.visible)
            .animation(.easeIn, value: livePredictionData)
            .foregroundColor(.accent)
        }
        .modifier(ChartViewStyle())
    }
    
    private func availableMLModelsToolbarItem() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            NavigationLink {
                MLModelListView()
                    .environment(appModel)
            } label: {
                Text("ML Models")
            }
        }
    }
}


#Preview {
    ContentView()
        .environment(AppModel())
}
