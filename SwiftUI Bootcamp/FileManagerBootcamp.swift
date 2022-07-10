//
//  FileManagerBootcamp.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 10.07.2022.
//

import SwiftUI

class LocalFileManager {
    
    static let inctance = LocalFileManager()
    
    private init() { }
    
    func saveImage(image: UIImage, name: String) {
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name) else {
                print("Error getting data")
                return
            }
        
        do {
            try data.write(to: path)
            print("Succes saving!")
        } catch let error {
            print("Saving error: \(error)")
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
                print("Error getting path")
                return nil
            }
        return UIImage(contentsOfFile: path)
    }
    
    func getPathForImage(name: String) -> URL? {
        guard let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent("\(name).jpg") else {
                    print("Error getting path")
                    return nil
                }
        return path
        
    }
    
    func deleteImage(name: String) {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
                print("Error getting path")
                return
            }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Sucessfully deleted")
        } catch let error {
            print("Error deleting: \(error)")
        }
    }
    
    
}


class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var fileManagerImage: UIImage?
    let fileManagerImageName = "photo2"
    let imageName = "photo"
    let manager = LocalFileManager.inctance
    
    
    init() {
        getImageFromAssets()
    }
    
    func getImageFromAssets() {
        self.image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        self.fileManagerImage = manager.getImage(name: fileManagerImageName)
    }
    
    func saveImage() {
        guard let image = image else  { return }
        manager.saveImage(image: image, name: fileManagerImageName)
    }
    
    func deleteImage() {
        manager.deleteImage(name: fileManagerImageName)
    }
    
}

struct FileManagerBootcamp: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to FM")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete from FM")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                
                Button {
                    vm.getImageFromFileManager()
                } label: {
                    Text("Get Image from FM")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                if let image = vm.fileManagerImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}
