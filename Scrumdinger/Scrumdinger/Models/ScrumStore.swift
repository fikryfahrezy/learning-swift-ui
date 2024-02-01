//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Fikry Fahrezy on 28/01/24.
//

import Foundation


@Observable
class ScrumStore {
    private static let fileName = "scrums.data"
    
    var scrums: [DailyScrum] = []
    
    func load() async throws {
        let scrums: [DailyScrum] = try await loadFromFileAsync(filename: ScrumStore.fileName, defaultValue: [])
        self.scrums = scrums
    }
    
    func save(scrums: [DailyScrum]) async throws {
        try await saveToFileAsync(filename: ScrumStore.fileName, value: scrums)
    }
}

func fileURL(_ filename: String) throws -> URL {
    try FileManager.default.url(
        for: .documentDirectory,
        in: .userDomainMask,
        appropriateFor: nil,
        create: false
    )
    .appendingPathComponent(filename)
}

func loadFromFile<T: Decodable>(filename: String, defaultValue: T)  throws -> T  {
    let file = try fileURL(filename)
    guard let data = try? Data(contentsOf: file) else {
        return defaultValue
    }
    let decoder = JSONDecoder()
    return try decoder.decode(T.self, from: data)
}


func loadFromFileAsync<T: Decodable>(filename: String, defaultValue: T) async throws -> T  {
    let task = Task<T, Error> {
        return try loadFromFile(filename: filename, defaultValue: defaultValue)
    }
    
    return try await task.value
}


func saveToFile<T: Encodable>(filename: String, value: T) throws {
    let encoder = JSONEncoder()
    let data = try encoder.encode(value)
    let outfile = try fileURL(filename)
    try data.write(to: outfile)
}


func saveToFileAsync<T: Encodable>(filename: String, value: T) async throws  {
    let task = Task {
        return try saveToFile(filename: filename, value: value)
    }
    
    try await task.value
}

