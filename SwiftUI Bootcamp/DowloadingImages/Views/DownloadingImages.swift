//
//  DownloadingImages.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 08.07.2022.
//

import SwiftUI

struct DownloadingImages: View {
    
    @StateObject var imagesViewModel = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(imagesViewModel.dataArray) { model in
                    DownloadImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}
