//
//  PandaCollectionFetcher.swift
//  MemeCreator
//
//  Created by Fikry Fahrezy on 26/05/24.
//

import SwiftUI

@Observable class PandaCollectionFetcher {
    var imageData = PandaCollection(sample: [Panda.defaultPanda])
    var currentPanda = Panda.defaultPanda
    
    let urlString = "http://playgrounds-cdn.apple.com/assets/pandaData.json"
    
    enum FetchError: Error {
        case badRequest
        case badJSON
    }
    
    func fetchData() async
    throws  {
        guard let url = URL(string: urlString) else { return }
        
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badRequest }

        
        Task {
            imageData = try JSONDecoder().decode(PandaCollection.self, from: data)
        }
    }
}

