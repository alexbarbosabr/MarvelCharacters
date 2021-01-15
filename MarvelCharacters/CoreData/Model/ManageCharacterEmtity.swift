//
//  ManageCharacterEmtity.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 27/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import CoreData

protocol ManageCharacterEmtityProtocol {
    func fetchCharacters() -> [CharacterEntity]
    func save(with character: Character, imageData: Data?) throws
    func delete(with character: Character) throws
}

class ManageCharacterEmtity: ManageCharacterEmtityProtocol {
    private let entityName: String = "Character"
    private var isRunningTests: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }

    func fetchCharacters() -> [CharacterEntity] {
        if isRunningTests { return [CharacterEntity]() }

        let dataManager = DataManager()
        let context = dataManager.persistentContainer.viewContext

        let reqquest = NSFetchRequest<CharacterEntity>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        reqquest.sortDescriptors = [sortDescriptor]

        do {
            let result = try context.fetch(reqquest)
            return result
        } catch {
            fatalError("Error in retriving items")
        }
    }

    func save(with character: Character, imageData: Data?) throws {
        if isRunningTests { return }

        let dataManager = DataManager()
        let context = dataManager.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        let characterData = NSManagedObject(entity: entity, insertInto: context)

        characterData.setValue(character.id, forKey: "id")
        characterData.setValue(character.name, forKey: "name")
        characterData.setValue(character.description, forKey: "desc")
        characterData.setValue(true, forKey: "favorite")
        characterData.setValue(character.thumbnail.extension, forKey: "extension")
        characterData.setValue(character.thumbnail.path, forKey: "path")
        characterData.setValue(imageData, forKey: "image")

        do {
            try context.save()
        } catch {
            printError(error)
            throw error
        }
    }

    func delete(with character: Character) throws {
        if isRunningTests { return }

        let dataManager = DataManager()
        let context = dataManager.persistentContainer.viewContext

        let reqquest = NSFetchRequest<CharacterEntity>(entityName: entityName)
        reqquest.predicate = NSPredicate(format: "id = \(character.id)")

        do {
            let result = try context.fetch(reqquest)

            for item in result {
                context.delete(item)
            }

            try context.save()
        } catch {
            printError(error)
            throw error
        }
    }

    private func printError(_ error: Error) {
        let err = error as NSError
        print("Could not delete. \(err), \(err.userInfo)")
    }
}
