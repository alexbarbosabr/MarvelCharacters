//
//  CharacterDAO.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 26/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation
import CoreData

public class CharacterDAO: NSManagedObject, Identifiable {
    @NSManaged public var desc: String?
    @NSManaged public var id: Int32
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
}

class ManageCharacterDAO {
    private let entityName: String = "Character"

    func fetchCharacters() -> [CharacterDAO] {
        let dataManager = DataManager()
        let context = dataManager.persistentContainer.viewContext

        let reqquest = NSFetchRequest<CharacterDAO>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        reqquest.sortDescriptors = [sortDescriptor]

        do {
            let result = try context.fetch(reqquest)
            return result
        } catch {
            fatalError("Error is retriving items")
        }
    }

    func save(with character: Character, imageData: Data?) {
        let dataManager = DataManager()
        let context = dataManager.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        let characterData = NSManagedObject(entity: entity, insertInto: context)

        characterData.setValue(character.id, forKey: "id")
        characterData.setValue(character.name, forKey: "name")
        characterData.setValue(character.description, forKey: "desc")
        characterData.setValue(imageData, forKey: "image")

        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func delete(with character: Character) {
        let dataManager = DataManager()
        let context = dataManager.persistentContainer.viewContext

        let reqquest = NSFetchRequest<CharacterDAO>(entityName: entityName)
        reqquest.predicate = NSPredicate(format: "id = \(character.id)")

        do {
            let result = try context.fetch(reqquest)

            for item in result {
                context.delete(item)
            }

            try context.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}
