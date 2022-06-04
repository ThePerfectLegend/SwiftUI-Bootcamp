//
//  Arrays.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 13.04.2022.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let points: Int
    let isVerified: Bool
}

class ArrayModeficationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        
        // Sort
//        filteredArray = dataArray.sorted(by: { $0.points > $1.points})
        
        // Filter
        filteredArray = dataArray.filter({ $0.isVerified })
        
        // Map
        mappedArray = dataArray.map({ $0.name })
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Nick", points: 10, isVerified: true)
        let user2 = UserModel(name: "John", points: 5, isVerified: false)
        let user3 = UserModel(name: "Alex", points: 8, isVerified: true)
        let user4 = UserModel(name: "Rick", points: 14, isVerified: false)
        let user5 = UserModel(name: "Joe", points: 9, isVerified: true)
        self.dataArray.append(contentsOf: [user1, user2, user3, user4, user5])

    }
}

struct Arrays: View {
    
    @State var viewModel = ArrayModeficationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(viewModel.filteredArray) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        HStack {
                            Text("Points: \(user.points)")
                            Spacer()
                            if user.isVerified {
                                Image(systemName: "flame.fill")
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue.cornerRadius(10))
                    .padding(.horizontal)
                }
            }
        }
    }
}
