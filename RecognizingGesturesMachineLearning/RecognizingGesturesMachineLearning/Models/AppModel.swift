//
//  AppModel.swift
//  RecognizingGesturesMachineLearning
//
//  Created by Fikry Fahrezy on 02/06/24.
//

import SwiftUI
import Vision
import CoreML

@Observable final class AppModel {
    static let defaultMLModelName = "rockpaperscissors.mlmodel"
    let camera = MLCamera()
    let predictionTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var currentMLModel: HandPoseMLModel? {
        didSet {
            guard let model = currentMLModel else { return }
            camera.mlDelegate?.updateMLModel(with: model)
        }
    }
    
    var defaultMLModel: HandPoseMLModel?
    var availableHandPoseMLModels = Set<HandPoseMLModel>()
    
    var nodePoints: [CGPoint] = []
    var isHandInFrame: Bool = false
    
    var predictionProbability = PredictionMetrics()
    var canPredict: Bool = false
    var predictionLabel: String = ""
    var isGatheringObservations: Bool = true
    
    var viewfinderImage: Image?
    var shouldPauseCamera: Bool = false {
        didSet {
            if shouldPauseCamera {
                camera.stop()
                isGatheringObservations = false
            } else {
                Task {
                    await camera.start()
                }
            }
        }
    }
    
    private var handposeMLModelURLs: [URL] {
        let urls = availableHandPoseMLModels.map { $0.url }
        return urls
    }
    
    init() {
        camera.mlDelegate = self
        setDefaultMLModel()
        Task {
            await handleCameraPreviews()
        }
    }
    
    func findExistingModels() async {
        let models = await HandPoseMLModel.findExistingModels(exclude: handposeMLModelURLs)
        for model in models {
            availableHandPoseMLModels.insert(model)
        }
    }
    
    func useLastTrainedModel() async {
        guard let lastTrained = await HandPoseMLModel.getLastTrainedModel() else {
            print("Couldn't find any recently trained ML models.")
            return
        }
        
        Task {
            self.currentMLModel = lastTrained
            print("Using last trained ML model in your RPS game: \(lastTrained.name)")
        }
    }
    
    private func handleCameraPreviews() async {
        let imageStream = camera.previewStream.map { $0.image }
        for await image in imageStream {
            Task {
                self.viewfinderImage = image
            }
        }
    }
    
    private func setDefaultMLModel()   {
        Task {
            guard let mlModel = await HandPoseMLModel.getDefaultMLModel() else { return }
            Task {
                self.defaultMLModel = mlModel
                self.currentMLModel = mlModel
                self.availableHandPoseMLModels.insert(mlModel)
            }
        }
    }
}

extension AppModel: MLDelegate {
    func updateMLModel(with model: NSObject) {
        guard let mlModel = model as? HandPoseMLModel else { return }
        camera.currentMLModel = mlModel
    }
    
    func gatherObservations(pixelBuffer: CVImageBuffer) async {
        guard canPredict else { return }
        
        Task {
            canPredict = false
        }
        
        guard let mlModel = camera.currentMLModel else {
            resetPrediction()
            return
        }
        
        Task {
            let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up)
            do {
                try imageRequestHandler.perform([camera.handPoseRequest])
                guard let observation = camera.handPoseRequest.results?.first else {
                    resetPrediction()
                    return
                }
                
                Task {
                    isHandInFrame = true
                    isGatheringObservations = true
                }
                
                let poseMultiArray = try observation.keypointsMultiArray()
                
                let input = HandPoseInput(poses: poseMultiArray)
                guard let output = try mlModel.predict(poses: input) else { return }
                updatePredictions(output: output)
                
                let jointPoints = try gatherHandPosePoints(from: observation)
                updateNodes(points: jointPoints)
            } catch {
                print("Error performing request: \(error)")
            }
        }
        
    }
    
    private func gatherHandPosePoints(from observation: VNHumanHandPoseObservation) throws -> [CGPoint] {
        let allPointsDict = try observation.recognizedPoints(.all)
        var allPoints: [VNRecognizedPoint] = Array(allPointsDict.values)
        allPoints = allPoints.filter { $0.confidence > 0.5 }
        let points: [CGPoint] = allPoints.map { $0.location }
        return points
    }
    
    private func updateNodes(points: [CGPoint]) {
        self.nodePoints = points
    }
    
    private func updatePredictions(output: HandPoseOutput) {
        predictionLabel = output.label.capitalized
        predictionProbability.getNewPredictions(from: output.labelProbabilities)
    }
    
    private func resetPrediction() {
        nodePoints = []
        predictionLabel = ""
        predictionProbability = PredictionMetrics()
        isHandInFrame = false
    }
}

fileprivate extension CIImage {
    var image: Image? {
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else { return nil }
        return Image(decorative: cgImage, scale: 1, orientation: .up)
    }
}

