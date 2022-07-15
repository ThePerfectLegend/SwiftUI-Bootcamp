//
//  DownloadWithCombine.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 15.07.2022.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    private func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background)) // Doing automaticly in dataTaskPublisher
            .receive(on: DispatchQueue.main) // receiving data in a main thread
            .tryMap(handleOutput) // checking if response is comes with correct status code and return data if code correc
            .decode(type: [PostModel].self, decoder: JSONDecoder()) // decoding data to Model
            .replaceError(with: []) // replace data if we have error
            .sink(receiveValue: { [weak self] (returnedPosts) in // assigning decoded data to Published variable
                self?.posts = returnedPosts
            })
            .store(in: &cancellables) // avalability to cancel subscription
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
        return output.data
    }
}

struct DownloadWithCombine: View {
    
    @StateObject var postsViewModel = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(postsViewModel.posts) { post in
                VStack(alignment: .leading)  {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(width: .infinity, height: .infinity)
            }
        }
    }
}

