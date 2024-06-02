//
//  TrainerDataModel.swift
//  MLTraining
//
//  Created by Fikry Fahrezy on 02/06/24.
//

import SwiftUI
import CoreML
import CreateML

@Observable final class TrainerDataModel {
    enum State: String {
        case inactive
        case active
        case finished
        case error
    }
    
    var trainingMetrics = TrainingMetrics()
    
    var modelName: String?
    var currentTrainer: HandPoseTrainer?
    var currentTrainingDataset: Dataset?
    var currentValidationDataset: Dataset?
    var completed: Double = 0.0
    var currentPhase: String = ""
    var currentState: State = .inactive
    
    var disableTrainingButton: Bool {
        guard let modelName = modelName, !modelName.isEmpty, let trainingDataset = currentTrainingDataset else { return true }
        return !trainingDataset.hasEnoughImages
    }
    
    var localTrainingDatasets: [Dataset] {
        guard let trainingDirectory = URL.trainingDirectoryInResources else { return [] }
        var datasets: [Dataset] = []
        for localURL in trainingDirectory.directoryContents {
            let folderName = localURL.lastPathComponent
            let dataset = Dataset(name: folderName,
                                  type: .training,
                                  moves: moves,
                                  resourceDirectory: localURL)
            datasets.append(dataset)
        }
        return datasets
    }
    
    var localValidationDatasets: [Dataset] {
        guard let trainingDirectory = URL.validationDirectoryInResources else { return [] }
        var datasets: [Dataset] = []
        for localURL in trainingDirectory.directoryContents {
            let folderName = localURL.lastPathComponent
            let dataset = Dataset(name: folderName,
                                  type: .validation,
                                  moves: moves,
                                  resourceDirectory: localURL)
            datasets.append(dataset)
        }
        return datasets
    }
    
    var localValidationDatasetNames: [String] {
        localValidationDatasets.map { $0.name }
    }
    
    var moves: [String] {
        GameModel().validMoveNames.map { $0.capitalized }
    }
    
    func reset() {
        trainingMetrics = TrainingMetrics()
        currentTrainer?.cancel()
        currentTrainer = nil
        currentTrainingDataset = nil
        currentValidationDataset = nil
        completed = 0.0
        currentPhase = ""
        currentState = .inactive
    }
}

