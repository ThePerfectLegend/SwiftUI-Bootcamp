//
//  DownloadingImagesViewModel.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 08.07.2022.
//

import Foundation

class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    
    let dataService = PhotoModelDataService.instance
    
    init() {
        Task {
            try? await fetchImagesData()
        }
    }
    
    func fetchImagesData() async throws {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")!
        
        guard let fethedData = try? await dataService.download(url: url) else {
                   throw URLError(.badServerResponse)
               }
        
        guard let photoModelData = try? JSONDecoder().decode([PhotoModel].self, from: fethedData) else {
                    throw URLError(.cannotCreateFile)
                }
        dataArray = photoModelData
    }
}
