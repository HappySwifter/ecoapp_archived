//
//  CoreDataHelpers.swift
//  EcoApp
//
//  Created by Artem on 29.05.2021.
//

import Foundation
import CoreData


let db = CoreDataHelpers()

class CoreDataHelpers {
    let context = appDelegate.persistentContainer.viewContext

    /// Дженерик функция для получения объектов БД
    func getObjects<T: NSManagedObject>(withId id: String? = nil,
                                        limit: Int? = nil,
                                        sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        
        
        let fetchRequest = NSFetchRequest<T>(entityName: T.description())
        if let limit = limit {
            fetchRequest.fetchLimit = limit
        }
        fetchRequest.sortDescriptors = sortDescriptors
        
        if let id = id {
            let predicate = NSPredicate(format: "objectId = %@", id)
            fetchRequest.predicate = predicate
        }
        do {
            let result = try context.fetch(fetchRequest)
            return result
            
        } catch {
            Log("Error \(error.localizedDescription)", type: .error)
            return []
        }
    }


    /// Создать новую запись в базе для заданной таблицы
    @nonobjc func createNew<T: NSManagedObject>() -> T {
        return NSEntityDescription.insertNewObject(forEntityName: T.description(), into: context) as! T
    }

}
