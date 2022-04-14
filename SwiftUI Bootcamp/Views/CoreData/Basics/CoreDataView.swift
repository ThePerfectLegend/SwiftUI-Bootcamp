//
//  CoreDataView.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 14.04.2022.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error Loading Core Data. \(error)")
            } else {
                print("Successfully Loaded Core Data")
            }
        }
        
        fetchFruits()
    }
    
    func addFruit(text: String, number: Double) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        newFruit.price = number
        saveFruits()
    }
    
    func updateFruit(fruit: FruitEntity) {
        fruit.price += 10
        saveFruits()
    }
    
    func saveFruits() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Saving is currupted. \(error)")
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func deleteFruit(IndexSet: IndexSet) {
       guard let index = IndexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveFruits()
    }
    
}

struct CoreDataView: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add fruit here", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 44)
                    .background(Color(#colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    guard !textFieldText.isEmpty else { return }
                    vm.addFruit(text: textFieldText, number: 10)
                    textFieldText = ""
                } label: {
                    Text("Add Fruit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 44)
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }

                
                List {
                    ForEach(vm.savedEntities) { entity in
                        HStack {
                            Text(entity.name ?? "No Name")
                            Spacer()
                            Text("\(entity.price )")
                        }
                        .onTapGesture {
                            vm.updateFruit(fruit: entity)
                        }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
        }
    }
}
