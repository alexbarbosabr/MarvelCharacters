//
//  DataManager.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 26/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import CoreData

final class DataManager {
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataMarvel")
        container.loadPersistentStores(completionHandler: { (_ storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
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
}
