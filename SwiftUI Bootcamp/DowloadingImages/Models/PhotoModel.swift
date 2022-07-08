//
//  PhotoModel.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 08.07.2022.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
