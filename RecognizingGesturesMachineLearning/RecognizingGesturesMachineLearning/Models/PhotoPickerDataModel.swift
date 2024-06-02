//
//  PhotoPickerDataModel.swift
//  RecognizingGesturesMachineLearning
//
//  Created by Fikry Fahrezy on 02/06/24.
//

import SwiftUI
import PhotosUI

@Observable class PhotoPickerDataModel {
    var selection: [PhotosPickerItem] = []
    
    func addImageFromPickerItem(_ pickerItem: PhotosPickerItem, to directory: URL) async {
        do {
            guard let imageFile = try await pickerItem.loadTransferable(type: PhotoFile.self) else { return  }
            let destURL = directory.appending(path: imageFile.name, directoryHint: .notDirectory)
            try FileManager.default.moveItem(at: imageFile.url, to: destURL)
        } catch {
            print("Error creating item from picked photo: \(error.localizedDescription)")
        }
    }
}

struct PhotoFile: Transferable {
    let name: String
    let url: URL
    
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .image, shouldAttemptToOpenInPlace: false) { data in
            SentTransferredFile(data.url, allowAccessingOriginalFile: true)
        } importing: { received in
            let tempDirectory = FileManager.default.temporaryDirectory
            let fileName = received.file.lastPathComponent
            let destinationURL = tempDirectory.appendingPathComponent(fileName)
            try FileManager.default.copyItem(at: received.file, to: destinationURL)
            return Self.init(name: fileName, url: destinationURL)
        }
    }
}

