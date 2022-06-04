//
//  Closures.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 04.06.2022.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello"
    
    func getData() {
        downloadData5 { [weak self] (returnedResult) in
            self?.text = returnedResult.data
        }
    }
    
    func downloadData() -> String {
        return "New Data!"
    }
    
    func downloadData2(complitionHandler: (_ data: String) -> Void) {
        complitionHandler("New Data")
    }
    
    func downloadData3(complitionHandler: @escaping (_ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        complitionHandler("New Data")
        }
    }
    
    func downloadData4(complitionHandler: @escaping (DowdloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DowdloadResult(data: "New Data")
            complitionHandler(result)
        }
    }
    
    func downloadData5(complitionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DowdloadResult(data: "New Data")
            complitionHandler(result)
        }
    }
}

struct DowdloadResult {
    let data: String
}

typealias DownloadCompletion = (DowdloadResult) -> Void

struct Closures: View {
    
    @StateObject var viewModel = EscapingViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .onTapGesture {
                viewModel.getData()
            }
    }
}

struct Closures_Previews: PreviewProvider {
    static var previews: some View {
        Closures()
    }
}
