//
//  PhotoModelDataService.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 08.07.2022.
//

import Foundation

class PhotoModelDataService {
    
    static let instance = PhotoModelDataService()
    
    private init() { }
        
    func download(url: URL) async throws -> Data {
        
        let (data, responce) = try await URLSession.shared.data(from: url)
        
        guard let outputResponce = responce as? HTTPURLResponse,
              outputResponce.statusCode >= 200 && outputResponce.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
}
