//
//  TrainingDatasetCell.swift
//  MLTraining
//
//  Created by Fikry Fahrezy on 02/06/24.
//

import SwiftUI

struct TrainingDatasetCell: View {
    @Environment(AppModel.self) var appModel
    var trainerDataModel: TrainerDataModel
    var dataset: Dataset
    @State private var newDatasets: [Dataset] = []
    private var totalImages: Int {
        dataset.getTotalImageCount()
    }
    
    var body: some View {
        NavigationLink {
            TrainingView(trainerDataModel: trainerDataModel, newDatasets: $newDatasets)
                .environment(appModel)
                .onAppear {
                    trainerDataModel.currentTrainingDataset = dataset
                }
        } label: {
            CellView(name: dataset.name, count: totalImages)
        }
        .modifier(CellStyle())
    }
}
