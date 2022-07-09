//
//  ImageLoadingViewModel.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 09.07.2022.
//

import Foundation
import SwiftUI

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading = false
    
    let dataService = PhotoModelDataService.instance
    let manager = PhotoModelCacheManager.instance
    
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        getImage()
    }
    
    func getImage() {
        if let cachedImage = manager.get(key: imageKey) {
            image = cachedImage
            print("Getting Image from Cache")
        } else {
            Task {
                try? await downloadImage()
                print("Downloading Image Now")
            }
        }
    }
    
    func downloadImage() async throws {
        
        await MainActor.run {
            isLoading = true
        }

        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        guard let fethedData = try? await dataService.download(url: url) else {
                   throw URLError(.badServerResponse)
               }
        
        guard let image = UIImage(data: fethedData) else {
            throw URLError(.cannotCreateFile)
        }
        
        await MainActor.run {
            self.image = image
            isLoading = false
        }
        
        manager.add(key: self.imageKey, value: image)
    }
}
