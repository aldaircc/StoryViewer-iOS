//
//  PersistentStorage.swift
//  ReignTest
//
//  Created by Aldair Raul Cosetito Coral on 12/06/21.
//

import Foundation
import CoreData

final class PersistentStorage {
    
    static let shared = PersistentStorage()
    
    //MARK: - CoreData stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StoryDatabase")
        container.loadPersistentStores { descriptor, error in
            if let error = error as NSError? {
                fatalError("unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    //MARK: - Methods
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else { return nil }
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
}
