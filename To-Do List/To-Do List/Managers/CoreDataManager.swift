//
//  CoreDataManager.swift
//  To-Do List
//
//  Created by Hasan Elhussein on 10.02.2022.
//

import Foundation
import CoreData

// MARK: - Protocol
protocol CoreDataManagerProtocol {
    func fetchData() -> [Task]
    func saveData(title: String, detail: String, creationDate: Date, completionDate: Date)
}


// MARK: - CoreDataManager class
class CoreDataManager {
    
    static let  shared = CoreDataManager()
    
    // *******************************************************************************************************************
    // Core Data stack (this code was generated automatically by xcode)
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "To_Do_List")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    // *******************************************************************************************************************

}


// MARK: - Extension
extension CoreDataManager: CoreDataManagerProtocol {
    // Function for fetching data from CoreData model
    func fetchData() -> [Task] {
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        let managedContext = persistentContainer.viewContext
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result
        } catch {
            debugPrint("Error while fetching data: \(error.localizedDescription)")
            return []
        }
        
    }
    
    // Function for saving data to CoreData model
    func saveData(title: String, detail: String, creationDate: Date, completionDate: Date) {
        let managedContext = persistentContainer.viewContext
        let task = Task(context: managedContext )
        task.title = title
        task.detail = detail
        task.creationDate = Date()
        task.completionDate = completionDate
        do {
            if managedContext.hasChanges{
                try  managedContext.save()
            }
        } catch  {
            debugPrint("Error while saving data: \(error.localizedDescription)")
        }
    }
    

    // *******************************************************************************************************************
    // Core Data Saving support (this code was generated automatically by xcode)
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    // *******************************************************************************************************************
    
}

