//
//  CoreDataRelationships.swift
//  SwiftUI Bootcamp
//
//  Created by Nizami Tagiyev on 14.04.2022.
//

import SwiftUI
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer // контейнер для извлечения данных
    let context: NSManagedObjectContext // объект управления данными в БД
    
    init() {
        // указание контейнера для загрузки
        container = NSPersistentContainer(name: "CoreDataContainer")
        
        // загрузка данных из указанного контейнера
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error Loading Core Data. \(error)")
            } else {
                print("Successfully Loaded Core Data")
            }
        }
        
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Save successfully")
        } catch let error {
            print("Saving is currupted. \(error.localizedDescription)")
        }
    }
    
}



class CoreDataRelationshipViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentsEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        fetchBusinesses()
        fetchDepartments()
        fetchEmployees()
    }
    
    func fetchBusinesses() {
        // критерии поиска для получения данных
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        // добавление сортировки в критерии
        let sort = NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)
        request.sortDescriptors = [sort]
        // фильтрация данных
//        let filter = NSPredicate(format: "business == %@", "Apple")
//        request.predicate = filter
        // передача сформированного кретерия в CoreDataManager для извлечения данных
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }
    
    func fetchDepartments() {
        let request = NSFetchRequest<DepartmentsEntity>(entityName: "DepartmentsEntity")
        
        do {
            departments = try manager.context.fetch(request)
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }
    
    func fetchEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        
        do {
            employees = try manager.context.fetch(request)
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }
    
    func addBusuiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple"
        
        // Добавление существующего департамента к бизнесу
    //        newBusiness.departments = []
        
        // Добавление сотрудников к бизнесу
    //        newBusiness.employees = []
        
        // Добавление нового бизнеса к существуюшему департаменту
    //        newBusiness.addToDepartments(<#T##value: DepartmentsEntity##DepartmentsEntity#>)
        
        // Добавление нового бизнеса к сотруднику
    //        newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)
        
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentsEntity(context: manager.context)
        newDepartment.name = "Marketing"
        newDepartment.businesses = [businesses[0]]
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.name = "Larry"
        newEmployee.age = 54
        newEmployee.dateJoined = Date()
        
        newEmployee.business = businesses[0]
        newEmployee.department = departments[0]
        save()
    }
    
    func deleteDepartment() {
        let department = departments[0]
        manager.context.delete(department)
        save()
    }
    
    func save() {
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.manager.save()
            self.fetchBusinesses()
            self.fetchDepartments()
            self.fetchEmployees()
        }
    }
    
}

struct CoreDataRelationships: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button {
                        vm.deleteDepartment()
                    } label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.cornerRadius(10))
                    }

                }
                .padding()
                
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(alignment: .top) {
                        ForEach(vm.businesses) { business in
                            BusinessView(entity: business)
                        }
                    }
                    .padding()
                }
                
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(alignment: .top) {
                        ForEach(vm.departments) { department in
                            DepartmentView(entity: department)
                        }
                    }
                    .padding()
                }
                
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(alignment: .top) {
                        ForEach(vm.employees) { employee in
                            EmployeeView(entity: employee)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Relationships")
        }
    }
}

struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            if let deparments = entity.departments?.allObjects as? [DepartmentsEntity] {
                Text("Deparments:")
                    .bold()
                ForEach(deparments) { deparment in
                    Text(deparment.name ?? "")
                }
            }
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}


struct DepartmentView: View {
    
    let entity: DepartmentsEntity
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses:")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.green.opacity(0.75))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct EmployeeView: View {
    
    let entity: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            Text("Businesses:")
                .bold()
            Text(entity.business?.name ?? "")
            
            
            Text("Deparments:")
                .bold()
            Text(entity.department?.name ?? "")
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.red.opacity(0.75))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
