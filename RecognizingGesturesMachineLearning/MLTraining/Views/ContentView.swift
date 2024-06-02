//
//  ContentView.swift
//  MLTraining
//
//  Created by Fikry Fahrezy on 02/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(AppModel.self) var appModel
    @State var trainerDataModel = TrainerDataModel()
    
    @State private var localDatasets: [Dataset] = []
    @State private var newDatasets: [Dataset] = []
    @State private var datasetName: String = ""
    @FocusState private var focusField: Bool
    
    private var allDatasetNames: [String] {
        localDatasets.map { $0.name } + newDatasets.map { $0.name }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(localDatasets) { dataset in
                        datasetCell(dataset)
                    }
                    ForEach(newDatasets) { dataset in
                        datasetCell(dataset)
                    }
                }
                .padding()
            }
            .toolbar {
                addDatasetToolbarItem()
            }
            .navigationTitle("Training Datasets")
        }
        .accentColor(.accent)
        .onAppear {
            localDatasets = getLocalDatasets()
        }
    }
    
    private func datasetCell(_ dataset: Dataset) -> some View {
        TrainingDatasetCell(trainerDataModel: trainerDataModel, dataset: dataset)
            .environment(appModel)
    }
    
    private func addDatasetToolbarItem() -> some ToolbarContent {
        ToolbarItem() {
            NavigationLink {
                TrainingView(trainerDataModel: trainerDataModel, newDatasets: $newDatasets)
                    .environment(appModel)
                    .onAppear {
                        let newDataset = Dataset(type: .training, moves: trainerDataModel.moves, isNew: true)
                        trainerDataModel.currentTrainingDataset = newDataset
                    }
            } label: {
                Label("Create a new dataset", systemImage: "plus")
                    .labelStyle(.iconOnly)
                
            }
        }
    }
    
    private func getLocalDatasets() -> [Dataset] {
        return trainerDataModel.localTrainingDatasets
    }
}

#Preview {
    ContentView()
        .environment(AppModel())
}
